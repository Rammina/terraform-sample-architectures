output "web_instance_public_ip" {
  value = aws_eip.web.public_ip
}

output "web_instance_id" {
  value = aws_instance.web.id
}
