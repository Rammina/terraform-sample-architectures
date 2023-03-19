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

resource "aws_instance" "web" {
  subnet_id              = var.public_subnet_id
  ami                    = data.aws_ami.amazon_linux_2.image_id # Amazon Linux 2 AMI
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.web_security_group_id]
  user_data              = data.template_file.user_data.rendered
}

resource "aws_eip" "web" {
  depends_on = [aws_instance.web]

  instance = aws_instance.web.id
  vpc      = true
}
