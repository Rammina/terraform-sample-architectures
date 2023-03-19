variable "parameter_group_family" {
  type    = string
  default = "mysql8.0"
}

variable "db_name" {
  description = "The name of the RDS database"
  type        = string
}

variable "username" {
  description = "The RDS database username"
  type        = string
}

variable "password" {
  description = "The RDS database password"
  type        = string
  sensitive   = true
}

variable "engine" {
  description = "The RDS database engine"
  type        = string
}

variable "engine_version" {
  description = "The RDS database engine version"
  type        = string
}

variable "instance_class" {
  description = "The RDS database instance class"
  type        = string
}

variable "allocated_storage" {
  description = "The RDS database allocated storage size"
  type        = number
}

variable "subnet_group_name" {
  description = "The name of the DB subnet group to use"
  type        = string
}

variable "rds_security_group_id" {
  description = "The name of the RDS security group to use"
  type        = string
}

variable "skip_final_snapshot" {
  description = "Set to true to skip final snapshot (for non-production environments)"
  type        = bool
  default     = false
}
