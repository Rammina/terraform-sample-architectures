# Resources
resource "aws_db_parameter_group" "rds" {
  family = var.parameter_group_family
}

resource "aws_db_instance" "rds" {
  db_name  = var.db_name
  username = var.username
  password = var.password

  allocated_storage    = var.allocated_storage
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  parameter_group_name = aws_db_parameter_group.rds.name

  db_subnet_group_name   = var.subnet_group_name
  vpc_security_group_ids = [var.rds_security_group_id]

  skip_final_snapshot = var.skip_final_snapshot
}
