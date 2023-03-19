output "cache_endpoints" {
  value = aws_elasticache_cluster.cache.cache_nodes[*].address
}

output "port" {
  value = aws_elasticache_cluster.cache.port
}

output "subnet_group_name" {
  value = aws_elasticache_cluster.cache.subnet_group_name
}

output "security_group_ids" {
  value = aws_elasticache_cluster.cache.security_group_ids
}

output "cache_cluster_id" {
  value = aws_elasticache_cluster.cache.id
}
