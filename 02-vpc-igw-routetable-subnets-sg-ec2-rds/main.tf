
provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "available" {
  state = "available"
}

# create resources
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = var.vpc_name
  }
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
  cidr_block = "10.0.4.0/24"
  # ...
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = data.aws_availability_zones.available.names[0] # different AZ than the other subnet
}

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = data.aws_availability_zones.available.names[1] # different AZ than the other subnet
}

resource "aws_db_subnet_group" "rds" {
  subnet_ids = [aws_subnet.private.id, aws_subnet.private_2.id]
}

resource "aws_db_parameter_group" "rds" {
  family = "mysql8.0"
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
}

resource "aws_security_group" "rds" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
  }
}

resource "aws_instance" "web" {
  subnet_id              = aws_subnet.public.id
  ami                    = "ami-0b5eea76982371e91" # Amazon Linux 2 AMI
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web.id]
  tags = {
    Name = var.instance_name
  }
}

resource "aws_eip" "web" {
  instance = aws_instance.web.id
  vpc      = true
}

resource "aws_db_instance" "rds" {
  allocated_storage      = 20
  engine                 = var.rds_engine
  engine_version         = var.rds_engine_version
  instance_class         = var.rds_class
  name                   = var.rds_name
  username               = var.rds_user
  password               = var.rds_password
  db_subnet_group_name   = aws_db_subnet_group.rds.name
  parameter_group_name   = aws_db_parameter_group.rds.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  skip_final_snapshot    = true
}
