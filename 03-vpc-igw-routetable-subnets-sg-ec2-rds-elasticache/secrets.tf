variable "rds_user" {
  type    = string
  default = "defaultUser"
}

variable "rds_password" {
  type      = string
  sensitive = true
}
