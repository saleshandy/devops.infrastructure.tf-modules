output "cloudwatch_metric_alarm_id" {
  value = "${aws_cloudwatch_metric_alarm.main.id}"
}

output "cloudwatch_metric_alarm_arn" {
  value = "${aws_cloudwatch_metric_alarm.main.arn}"
}