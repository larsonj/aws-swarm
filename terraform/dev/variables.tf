#
# Docker Swarm Variables
#
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
variable "vpc_id" {
   default = "ivpc-95c708f3"
}

#
# AWS Variables
#
# TODO: create VPC through terraform and subsequent script to populate TF_VAR's
variable "vpc_cidr" {
    description = "CIDR for VPC"
    default = "10.0.0.0/20"
}
variable "public_subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default = "10.0.0.0/24"
}
variable "az_list" {
  description = "Run the EC2 Instances in these Availability Zones"
  type = "list"
  default = ["us-east-1c", "us-east-1d", "us-east-1e"]
}
variable "az_list_count" { # used to spread vm nodes across az's; must = number of az in az-list variable
   default = 2
}
# TODO: script to retrieve proper subnets from AWS-CLI and update env TF_VAR's
variable "public_subnet_list" {
  description = "Launch instances across these subnetss"
  type = "list"
  default = ["subnet-277b026e", "subnet-f7db58ac", "subnet-4258f97e"] # all should reside in the az's from az-list; MUST UPDATE subnet_list_count
}
variable "subnet_list_count" { # used to spread vm nodes across az's; must = number of az in az-list variable
   default = 2
}

