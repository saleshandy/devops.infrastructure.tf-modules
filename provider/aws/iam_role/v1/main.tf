resource "aws_iam_role" "main" {
  name = var.name

  assume_role_policy  = var.assume_role_policy
  managed_policy_arns = var.managed_policy_arns
  tags = var.tags
}

