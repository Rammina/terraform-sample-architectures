locals {
  all_ip_cidr = "0.0.0.0/0"

  ingress_rules = {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


}
