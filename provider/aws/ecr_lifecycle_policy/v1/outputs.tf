output "ecr_lifecycle_policy_registry_id" {
  value = "${aws_ecr_lifecycle_policy.main.registry_id}"
}

output "ecr_lifecycle_policy_repository" {
  value = "${aws_ecr_lifecycle_policy.main.repository}"
}