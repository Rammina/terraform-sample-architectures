provider "aws" {
  region = var.region

  default_tags {
    tags = {
      environment  = local.environment
      project_name = local.project_name
    }
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.*-x86_64-gp2"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

data "template_file" "user_data" {
  template = file("${path.module}/sh/ec2-init.sh")
}

# Resources
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags       = local.common_tags
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.main.main_route_table_id
  destination_cidr_block = local.all_ip_cidr
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_vpc.main.main_route_table_id
}


resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.99.0/24"
}

resource "aws_subnet" "private" {
  count = var.private_subnet_count

  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.${count.index}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]
}

resource "aws_db_subnet_group" "rds" {
  subnet_ids = aws_subnet.private[*].id
}

resource "aws_db_parameter_group" "rds" {
  family = var.rds_parameter_group_family
}

resource "aws_elasticache_subnet_group" "elasticache" {
  name       = var.cache_subnet_group_name
  subnet_ids = aws_subnet.private[*].id
}

resource "aws_security_group" "web" {
  name        = "web"
  description = "Allow SSH inbound traffic from anywhere"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [local.all_ip_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [local.all_ip_cidr]
  }
}

resource "aws_security_group" "rds" {
  vpc_id = aws_vpc.main.id

  ingress {
    description     = "MySQL access from within VPC"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [local.all_ip_cidr]
  }
}

resource "aws_security_group" "elasticache" {
  name        = "elasticache-security-group"
  description = "Security group for Elasticache"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Redis access from within VPC"
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [local.all_ip_cidr]
  }
}

resource "aws_instance" "web" {
  subnet_id              = aws_subnet.public.id
  ami                    = data.aws_ami.amazon_linux_2.image_id # Amazon Linux 2 AMI
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web.id]
  user_data              = data.template_file.user_data.rendered
  tags                   = local.common_tags
}

resource "aws_eip" "web" {
  instance = aws_instance.web.id
  vpc      = true
}

resource "aws_db_instance" "rds" {
  db_name  = "${local.resource_name_prefix}db"
  username = var.rds_user
  password = var.rds_password

  allocated_storage = var.rds_allocated_storage
  engine            = var.rds_engine
  engine_version    = var.rds_engine_version
  instance_class    = var.rds_class

  db_subnet_group_name   = aws_db_subnet_group.rds.name
  parameter_group_name   = aws_db_parameter_group.rds.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  skip_final_snapshot    = true
}

resource "aws_elasticache_cluster" "cache" {
  cluster_id           = "${lower(local.resource_name_prefix)}-cluster"
  engine               = var.cache_engine
  node_type            = var.cache_node_type
  num_cache_nodes      = var.cache_num_nodes
  parameter_group_name = var.cache_parameter_group_name
  engine_version       = var.cache_engine_version
  port                 = var.cache_port
  subnet_group_name    = aws_elasticache_subnet_group.elasticache.name
  security_group_ids   = [aws_security_group.elasticache.id]
}

