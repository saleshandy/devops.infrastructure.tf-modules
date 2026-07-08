resource "aws_lb_listener_certificate" "main" {
  listener_arn    = var.listener_arn
  certificate_arn = var.certificate_arn
}