output "ssm_parameter_name" {
  description = "The name of the parameter"
  value       = aws_ssm_parameter.main.name
}

output "ssm_parameter_arn" {
  description = "The ARN of the parameter"
  value       = aws_ssm_parameter.main.arn
}

output "ssm_parameter_type" {
  description = "The type of the parameter"
  value       = aws_ssm_parameter.main.type
}

output "ssm_parameter_value" {
  description = "The value of the parameter"
  value       = aws_ssm_parameter.main.value
  sensitive   = true
}

output "ssm_parameter_version" {
  description = "The version of the parameter"
  value       = aws_ssm_parameter.main.version
}

output "ssm_parameter_tier" {
  description = "The tier of the parameter"
  value       = aws_ssm_parameter.main.tier
}

output "ssm_parameter_key_id" {
  description = "The KMS key ID used to encrypt the parameter"
  value       = aws_ssm_parameter.main.key_id
}
