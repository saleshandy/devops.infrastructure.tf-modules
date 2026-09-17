resource "aws_kms_key" "main" {
  description              = var.description
  key_usage                = var.key_usage
  customer_master_key_spec = var.customer_master_key_spec
  enable_key_rotation      = var.enable_key_rotation
  rotation_period_in_days  = var.enable_key_rotation ? var.rotation_period_in_days : null
  deletion_window_in_days  = var.deletion_window_in_days
  multi_region             = var.multi_region
  policy                   = var.policy

  tags = var.tags
}

resource "aws_kms_alias" "main" {
  count = var.alias_name != null ? 1 : 0

  name          = "alias/${trimprefix(var.alias_name, "alias/")}"
  target_key_id = aws_kms_key.main.key_id
}
