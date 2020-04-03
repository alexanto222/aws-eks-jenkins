variable "cluster-name" {
  default = "terraform-eks"
  type    = string
}
variable "vpc-cidr" {
  default = "30.0.0.0/16"
}
variable "region" {
  description = "The AWS region to create resources in."
  default     = "us-east-1"
}

variable "availability_zone" {
  description = "The availability zone"
  default     = "eu-west-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "private_key" {
  default = "mykey"
}

variable "public_key" {
  default = "mykey.pub"
}

#datasource
#data "aws_availability_zones" "azs" {
#  state = "available"
#}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

