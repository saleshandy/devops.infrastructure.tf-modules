# Account-level, per-region settings: they apply to every new EBS volume in the region
# (instances, launch templates, EBS CSI volumes, snapshot copies), not only to this module's callers.
resource "aws_ebs_default_kms_key" "main" {
  # Keyed off a bool, not kms_key_arn != null: the ARN of a key created in the same apply
  # is unknown at plan time, and count must be known then
  count = var.use_aws_managed_key ? 0 : 1

  key_arn = var.kms_key_arn

  lifecycle {
    precondition {
      condition     = var.kms_key_arn != null
      error_message = "kms_key_arn is required unless use_aws_managed_key = true."
    }
  }
}

resource "aws_ebs_encryption_by_default" "main" {
  # Set the default key first, so no volume is created with aws/ebs in between
  depends_on = [aws_ebs_default_kms_key.main]

  enabled = var.enabled
}
