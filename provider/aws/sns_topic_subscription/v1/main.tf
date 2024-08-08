resource "aws_sns_topic_subscription" "main" {
  count = length(var.email_ids)
  topic_arn = var.topic_arn
  protocol  = var.protocol
  endpoint  = var.email_ids[count.index]
}
