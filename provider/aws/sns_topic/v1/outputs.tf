output "sns_topic_id" {
  value = "${aws_sns_topic.main.id}"
}

output "sns_topic_arn" {
  value = "${aws_sns_topic.main.arn}"
}