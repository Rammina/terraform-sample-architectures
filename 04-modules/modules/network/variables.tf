# VPC & Networks
variable "vpc_name" {
  type    = string
  default = "MyVpc"
}

variable "private_subnet_count" {
  type    = number
  default = 2 # for minimum high availability and multi-AZ
}

# RDS
variable "rds_subnet_group_name" {
  type        = string
  description = "Name of RDS subnet group"
  default     = "my-rds-subnet-group"
}

# Elasticache
variable "cache_subnet_group_name" {
  type        = string
  description = "Name of ElastiCache subnet group"
  default     = "my-cache-subnet-group"
}
