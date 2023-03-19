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

# RDS
variable "rds_allocated_storage" {
  type = number

  validation {
    condition     = var.rds_allocated_storage >= 20 && var.rds_allocated_storage % 1 == 0
    error_message = "Storage must be >= 20GB and incremented by 1GB."
  }
  default = 20
}

variable "rds_engine" {
  type    = string
  default = "mysql"
}

variable "rds_engine_version" {
  type    = string
  default = "8.0"
}

variable "rds_parameter_group_family" {
  type    = string
  default = "mysql8.0"
}

variable "rds_class" {
  type    = string
  default = "db.t3.micro"
}

variable "skip_final_snapshot" {
  description = "Set to true to skip final snapshot (for non-production environments)"
  type        = bool
  default     = false
}

# Elasticache
variable "cache_subnet_group_name" {
  type        = string
  description = "Name of ElastiCache subnet group"
  default     = "MyCacheSubnetGroup"
}

variable "cache_engine" {
  type        = string
  description = "Cache engine to use"
  default     = "redis"
}

variable "cache_node_type" {
  type        = string
  description = "Node type to use for the cache cluster"
  default     = "cache.t2.micro"
}

variable "cache_num_nodes" {
  type        = number
  description = "Number of nodes in the cache cluster"
  default     = 1
}

variable "cache_parameter_group_name" {
  type        = string
  description = "Name of the parameter group to associate with this cache cluster"
  default     = "default.redis7"
}

variable "cache_engine_version" {
  type        = string
  description = "Version number of the cache engine to use"
  default     = "7.0"
}

variable "cache_port" {
  type        = number
  description = "Port number on which to accept connections for this cache cluster"
  default     = 6379
}
