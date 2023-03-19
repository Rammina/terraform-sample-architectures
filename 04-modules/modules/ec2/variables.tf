# Network
variable "public_subnet_id" {
  type = string
}

variable "web_security_group_id" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}
