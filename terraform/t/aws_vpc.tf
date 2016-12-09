provider "aws" {
   access_key = "${var.access_key}"
   secret_key = "${var.secret_key}"
   region     = "${var.region}"
}

# VPC
#########################
/* Define our vpc */
resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  tags { 
    Name = "example VPC" 
  }
}

resource "aws_internet_gateway" "default" {
   vpc_id = "${aws_vpc.default.id}"
}

# Public subnets
#########################

resource "aws_subnet" "public_subnet_dmz_az-1" {
   count = 9 # generate 9 class C/24 subnets
   vpc_id = "${aws_vpc.default.id}"
   cidr_block = "${cidrsubnet(data.aws_vpc.selected.cidr_block, 4, 1)}"
   availability_zone = "us-east-1b"

  tags { 
    Name = "dmz"
  }
}

resource "aws_subnet" "public_subnet_app_az-1" {
   vpc_id = "${aws_vpc.default.id}"
   cidr_block = "192.168.101.0/24"
   availability_zone = "us-east-1d"

   tags { 
      Name = "app" 
  }
}

#resource "aws_subnet" "example" {
#  vpc_id            = "${data.aws_vpc.selected.id}"
#  availability_zone = "us-east-1e"
#  cidr_block        = "${cidrsubnet(data.aws_vpc.selected.cidr_block, 4, 1)}"
#}

# Routing for public subnets
#########################

resource "aws_route_table" "us-east-1-public-test" {
   vpc_id = "${aws_vpc.default.id}"

   route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.default.id}"
   }
}

resource "aws_route_table_association" "us-east-1b-public-test" {
   subnet_id = "${aws_subnet.us-east-1b-public-test.id}"
   route_table_id = "${aws_route_table.us-east-1-public-test.id}"
}

resource "aws_route_table_association" "us-east-1d-public-test" {
   subnet_id = "${aws_subnet.us-east-1d-public-test.id}"
   route_table_id = "${aws_route_table.us-east-1-public-test.id}"
}