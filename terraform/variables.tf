variable "swarm_manager_token" {
  default = ""
}
variable "swarm_worker_token" {
  default = ""
}
variable "swarm_ami_id" {
  default = "unknown"
}
variable "swarm_manager_ip" {
  default = ""
}
variable "swarm_managers" {
  default = 3
}
variable "swarm_workers" {
  default = 2
}
variable "swarm_instance_type" {
  default = "t2.micro"
}
variable "swarm_init" {
  default = false
}
variable "az-list" {
  description = "Run the EC2 Instances in these Availability Zones"
  type = "list"
  default = ["us-east-1c", "us-east-1d", "us-east-1e"]
}
variable "az-total-count" {
   default = 3
}
variable "vpc-id" {
   default = "ivpc-95c708f3"
}
