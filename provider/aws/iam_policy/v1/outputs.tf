output "iam_policy_name" {
  value = "${aws_iam_policy.main.name}"
}

output "iam_policy_arn" {
  value = "${aws_iam_policy.main.arn}"
}