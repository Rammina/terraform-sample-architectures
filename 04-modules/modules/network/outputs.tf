output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.rds.name
}

output "elasticache_subnet_group_name" {
  value = aws_elasticache_subnet_group.elasticache.name
}

output "web_security_group_id" {
  value = aws_security_group.web.id
}

output "rds_security_group_id" {
  value = aws_security_group.rds.id
}

output "elasticache_security_group_id" {
  value = aws_security_group.elasticache.id
}
