resource "aws_ecr_lifecycle_policy" "main" {
  repository = var.repository

  policy = var.policy
}