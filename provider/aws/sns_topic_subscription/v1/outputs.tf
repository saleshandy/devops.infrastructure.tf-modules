output "sns_topic_subscription_id" {
  value = "${aws_sns_topic_subscription.main[0].id}"
}

output "sns_topic_subscription_arn" {
  value = "${aws_sns_topic_subscription.main[0].arn}"
}