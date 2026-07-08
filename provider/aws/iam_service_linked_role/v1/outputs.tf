output "arn" {
  description = "The ARN of the IAM service linked role"
  value       = aws_iam_service_linked_role.main.arn
}

output "name" {
  description = "The name of the IAM service linked role"
  value       = aws_iam_service_linked_role.main.name
}

output "unique_id" {
  description = "The unique ID assigned by AWS to the IAM service linked role"
  value       = aws_iam_service_linked_role.main.unique_id
}