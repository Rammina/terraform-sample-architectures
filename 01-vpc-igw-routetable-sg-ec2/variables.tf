# Project
variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

# AWS
variable "region" {
  type    = string
  default = "us-east-1"
}

# VPC & Networks
variable "vpc_name" {
  type    = string
  default = "MyVpc"
}

variable "private_subnet_count" {
  type    = number
  default = 2 # for minimum high availability and multi-AZ
}

# EC2
variable "instance_type" {
  type    = string
  default = "t3.micro"
}
