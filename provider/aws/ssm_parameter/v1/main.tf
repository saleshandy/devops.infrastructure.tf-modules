resource "aws_ssm_parameter" "main" {
  name            = var.name
  type            = var.type
  value           = var.value
  description     = var.description
  tier            = var.tier
  key_id          = var.key_id
  overwrite       = var.overwrite
  allowed_pattern = var.allowed_pattern
  data_type       = var.data_type

  tags = var.tags
}
