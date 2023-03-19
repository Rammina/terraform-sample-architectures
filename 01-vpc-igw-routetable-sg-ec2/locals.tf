locals {
  all_ip_cidr  = "0.0.0.0/0"
  all_protocol = "-1"

  project_name         = var.project_name
  environment          = var.environment
  resource_name_prefix = "${local.project_name}${local.environment}"

  common_tags = {
    Name         = "${local.project_name}-${local.environment}" # for naming resources
    project_name = local.project_name
    environment  = local.environment
  }
}
