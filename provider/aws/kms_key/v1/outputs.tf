output "kms_key_id" {
  value = aws_kms_key.main.key_id
}

output "kms_key_arn" {
  value = aws_kms_key.main.arn
}

output "kms_alias_name" {
  value = try(aws_kms_alias.main[0].name, null)
}

output "kms_alias_arn" {
  value = try(aws_kms_alias.main[0].arn, null)
}
