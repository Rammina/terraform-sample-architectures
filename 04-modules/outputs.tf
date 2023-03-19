# EC2
output "web_instance_public_ip" {
  value = module.ec2.web_instance_public_ip
}

output "web_instance_id" {
  value = module.ec2.web_instance_id
}

# RDS
output "rds_instance_id" {
  value = module.rds.rds_instance_id
}

output "rds_instance_endpoint" {
  value = module.rds.rds_instance_endpoint
}

# Elasticache
output "cache_cluster_id" {
  value = module.elasticache.cache_cluster_id
}

output "cache_endpoints" {
  value = module.elasticache.cache_endpoints
}

output "cache_port" {
  value = module.elasticache.port
}
