resource "aws_lb_listener" "main" {
  load_balancer_arn = var.load_balancer_arn
  port              = var.port
  protocol          = var.protocol
	ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn
  alpn_policy       = var.alpn_policy

  default_action {
    type             = var.type
    target_group_arn = var.target_group_arn

    dynamic "redirect" {
      for_each = var.type == "redirect" ? ["true"] : []

      content {
        port        = var.redirect_port
      	protocol    = var.redirect_protocol
      	status_code = var.redirect_status_code
      }
    }
  }
}