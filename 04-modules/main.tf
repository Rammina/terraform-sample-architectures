provider "aws" {
  region = var.region

  default_tags {
    tags = {
      environment  = var.environment
      project_name = var.project_name
    }
  }
}

module "network" {
  source = "./modules/network"

  vpc_name                = var.vpc_name
  private_subnet_count    = var.private_subnet_count
  rds_subnet_group_name   = var.rds_subnet_group_name
  cache_subnet_group_name = var.cache_subnet_group_name
}

module "ec2" {
  source = "./modules/ec2"

  public_subnet_id      = module.network.public_subnet_id
  web_security_group_id = module.network.web_security_group_id
}

module "rds" {
  source = "./modules/rds"

  db_name               = var.rds_db_name
  username              = var.rds_user
  password              = var.rds_password
  engine                = var.rds_engine
  engine_version        = var.rds_engine_version
  instance_class        = var.rds_class
  allocated_storage     = var.rds_allocated_storage
  subnet_group_name     = var.rds_subnet_group_name
  rds_security_group_id = module.network.rds_security_group_id

  parameter_group_family = var.rds_parameter_group_family
  skip_final_snapshot    = var.skip_final_snapshot
}

module "elasticache" {
  source = "./modules/elasticache"

  elasticache_security_group_id = module.network.elasticache_security_group_id
  cluster_id                    = var.cache_cluster_id
  subnet_group_name             = var.cache_subnet_group_name
  engine                        = var.cache_engine
  node_type                     = var.cache_node_type
  num_cache_nodes               = var.cache_num_nodes
  parameter_group_name          = var.cache_parameter_group_name
  engine_version                = var.cache_engine_version
  port                          = var.cache_port
}
