# Account-level, per-region settings: they apply to every new EBS volume in the region
# (instances, launch templates, EBS CSI volumes, snapshot copies), not only to this module's callers.
resource "aws_ebs_default_kms_key" "main" {
  count = var.kms_key_arn != null ? 1 : 0

  key_arn = var.kms_key_arn
}

resource "aws_ebs_encryption_by_default" "main" {
  # Set the default key first, so no volume is created with aws/ebs in between
  depends_on = [aws_ebs_default_kms_key.main]

  enabled = var.enabled
}
