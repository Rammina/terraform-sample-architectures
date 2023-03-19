variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_name" {
  type    = string
  default = "MyVpc"
}

variable "instance_name" {
  type    = string
  default = "MyEC2Instance"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "rds_name" {
  type    = string
  default = "MyRdsDbName"
}

variable "rds_engine" {
  type    = string
  default = "mysql"
}

variable "rds_engine_version" {
  type    = string
  default = "8.0"
}

variable "rds_class" {
  type    = string
  default = "db.t3.micro"
}
