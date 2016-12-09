resource "aws_instance" "swarm-manager" {
  count = "${var.swarm_managers}"
  ami = "${var.swarm_ami_id}"
  instance_type = "${var.swarm_instance_type}"
  instance_initiated_shutdown_behavior = "terminate"

  # spread managers across availability zones listed in var.az_list
#  availability_zone = "${element(var.az_list, count.index % var.az_list_count)}"
  availability_zone = "${element(var.az_list, count.index )}"

  # launch instances in these vpc subnets
#  subnet_id = "${element(var.public_subnet_list, count.index % var.subnet_list_count)}"
  subnet_id = "${element(var.public_subnet_list, count.index)}"

  associate_public_ip_address = "true"

  tags {
    Name = "swarm-manager-${count.index}"
  }
  vpc_security_group_ids = [
    "${aws_security_group.docker.id}"
 ] 
  key_name = "devops21"
  connection {
    user = "ubuntu"
    private_key = "${file("~/.ssh/devops21.pem")}"
   agent = "false"
  }
  provisioner "remote-exec" {
    inline = [
      "if ${var.swarm_init}; then docker swarm init --advertise-addr ${self.private_ip}; fi",
      "if ! ${var.swarm_init}; then docker swarm join --token ${var.swarm_manager_token} --advertise-addr ${self.private_ip} ${var.swarm_manager_ip}:2377; fi"
    ]
  }
}

resource "aws_instance" "swarm-worker" {
  count = "${var.swarm_workers}"
  ami = "${var.swarm_ami_id}"
  instance_type = "${var.swarm_instance_type}"
  instance_initiated_shutdown_behavior = "terminate"

  # spread workers across availability zones listed in var.az_list
  availability_zone = "${element(var.az_list, count.index % var.az_list_count)}"

  # launch instances in these vpc subnets
  subnet_id = "${element(var.public_subnet_list, count.index % var.subnet_list_count)}"

  associate_public_ip_address = "true"

  tags {
    Name = "swarm-worker-${count.index}"
  }
  vpc_security_group_ids = [
    "${aws_security_group.docker.id}"
  ]
  key_name = "devops21"
  connection {
    user = "ubuntu"
    private_key = "${file("~/.ssh/devops21.pem")}"
  }
  provisioner "remote-exec" {
    inline = [
      "echo \"docker swarm join --token ${var.swarm_worker_token} --advertise-addr ${self.private_ip} ${var.swarm_manager_ip}:2377\"",
      "docker swarm join --token ${var.swarm_worker_token} --advertise-addr ${self.private_ip} ${var.swarm_manager_ip}:2377"
    ]
  }
}
output "swarm_manager_1_public_ip" {
  value = "${aws_instance.swarm-manager.0.public_ip}"
}

output "swarm_manager_1_private_ip" {
  value = "${aws_instance.swarm-manager.0.private_ip}"
}

output "swarm_manager_2_public_ip" {
  value = "${aws_instance.swarm-manager.1.public_ip}"
}

output "swarm_manager_2_private_ip" {
  value = "${aws_instance.swarm-manager.1.private_ip}"
}

output "swarm_manager_3_public_ip" {
  value = "${aws_instance.swarm-manager.2.public_ip}"
}

output "swarm_manager_3_private_ip" {
  value = "${aws_instance.swarm-manager.2.private_ip}"
}
output "s3_bucket_arn" {  value = "${aws_s3_bucket.terraform_state.arn}"}

