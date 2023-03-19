output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "web_instance_public_ip" {
  value = aws_eip.web.public_ip
}

output "web_instance_id" {
  value = aws_instance.web.id
}

output "rds_instance_id" {
  value = aws_db_instance.rds.id
}

output "rds_instance_endpoint" {
  value = aws_db_instance.rds.endpoint
}

output "cache_cluster_id" {
  value = aws_elasticache_cluster.cache.id
}
