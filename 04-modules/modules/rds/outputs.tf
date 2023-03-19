# The RDS instance ID.
output "rds_instance_id" {
  value = aws_db_instance.rds.id
}

# The connection endpoint in address:port format.
output "rds_instance_endpoint" {
  value = aws_db_instance.rds.endpoint
}
