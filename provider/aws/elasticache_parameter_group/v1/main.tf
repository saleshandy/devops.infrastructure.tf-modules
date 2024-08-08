resource "aws_elasticache_parameter_group" "main" {
  name   = var.name
  family = var.family

  description = var.description
  tags        = var.tags
}
