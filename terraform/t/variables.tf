variable "access_key" { 
  default = ""
  description = "AWS access key"
}

variable "secret_key" { 
  default = ""
  description = "AWS secret access key"
}

variable "region"     { 
  description = "AWS region to host your network"
  default     = "us-east-1" 
}

##################################################################################
# VPC Address Space - CIDR/20 (16 Class C Networks)
# 7 reserved class C address for additional subnets  *.*.3-4.*, *.*.8-9, *.*.13-15
##################################################################################
variable "vpc_cidr" {
  description = "CIDR for VPC"
  default     = "192.168.0.0/20"
}

########################################
# AZ-1 Subnets
########################################
variable "public_subnet_dmz_az-1_cidr" {
  description = "CIDR for public subnet"
  default     = "192.168.0.0/24"
  class-c-addr= 0
}

variable "public_subnet_app_az-1_cidr" {
  description = "CIDR for private subnet"
  default     = "192.168.1.0/24"
  class-c-addr= 1 
}

variable "public_subnet_data_az-1_cidr" {
  description = "CIDR for private subnet"
  default     = "192.168.2.0/24"
  class-c-addr= 2
}
########################################

########################################
# AZ-2 Subnets 
########################################
variable "public_subnet_dmz_az-2_cidr" {
  description = "CIDR for public subnet"
  default     = "192.168.5.0/24"
  class-c-addr= 5
}

variable "public_subnet_app_az-2_cidr" {
  description = "CIDR for private subnet"
  default     = "192.168.6.0/24"
  class-c-addr= 6
}

variable "public_subnet_data_az-2_cidr" {
  description = "CIDR for private subnet"
  default     = "192.168.7.0/24"
  class-c-addr= 7
}
########################################
# AZ-3 Subnets
########################################
variable "public_subnet_dmz_az-3_cidr" {
  description = "CIDR for public subnet"
  default     = "192.168.10.0/24"
  class-c-addr= 10
}

variable "public_subnet_app_az-3_cidr" {
  description = "CIDR for private subnet"
  default     = "192.168.11.0/24"
  class-c-addr= 11
}

variable "public_subnet_data_az-3_cidr" {
  description = "CIDR for private subnet"
  default     = "192.168.12.0/24"
  class-c-addr= 12
}
