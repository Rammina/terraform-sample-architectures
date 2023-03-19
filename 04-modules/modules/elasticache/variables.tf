variable "elasticache_security_group_id" {
  description = "The name of the ElastiCache security group to use"
  type        = string
}

variable "cluster_id" {
  type        = string
  description = "ID of ElastiCache cluster"
}

variable "subnet_group_name" {
  type        = string
  description = "Name of ElastiCache subnet group"
  default     = "MyCacheSubnetGroup"
}

variable "engine" {
  type        = string
  description = "Cache engine to use"
  default     = "redis"
}

variable "node_type" {
  type        = string
  description = "Node type to use for the cache cluster"
  default     = "cache.t2.micro"
}

variable "num_cache_nodes" {
  type        = number
  description = "Number of nodes in the cache cluster"
  default     = 1
}

variable "parameter_group_name" {
  type        = string
  description = "Name of the parameter group to associate with this cache cluster"
  default     = "default.redis7"
}

variable "engine_version" {
  type        = string
  description = "Version number of the cache engine to use"
  default     = "7.0"
}

variable "port" {
  type        = number
  description = "Port number on which to accept connections for this cache cluster"
  default     = 6379
}

