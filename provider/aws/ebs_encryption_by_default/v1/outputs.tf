output "ebs_encryption_by_default_enabled" {
  value = aws_ebs_encryption_by_default.main.enabled
}

output "ebs_default_kms_key_arn" {
  value = try(aws_ebs_default_kms_key.main[0].key_arn, null)
}
