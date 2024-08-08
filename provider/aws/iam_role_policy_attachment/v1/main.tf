resource "aws_iam_role_policy_attachment" "main" {
  role       = "${var.role}"
  count      = "${length(var.policy_arn)}"
  policy_arn = "${var.policy_arn[count.index]}"
}