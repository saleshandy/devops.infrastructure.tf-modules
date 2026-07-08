output "iam_instance_profile_id" {
  value = "${aws_iam_instance_profile.main.id}"
}

output "iam_instance_profile_arn" {
  value = "${aws_iam_instance_profile.main.arn}"
}

output "iam_instance_profile_name" {
  value = "${aws_iam_instance_profile.main.name}"
}