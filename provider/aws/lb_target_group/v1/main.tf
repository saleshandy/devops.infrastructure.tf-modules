resource "aws_lb_target_group" "main" {
  name        = var.name
  port        = var.port
  protocol    = var.protocol
  target_type = var.target_type
  vpc_id      = var.vpc_id

  health_check {
    protocol = var.health_check_protocol
    path =  var.health_check_path
    port = var.health_check_port
    healthy_threshold = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
    timeout = var.health_check_timeout
    interval = var.health_check_interval
    matcher = var.health_check_matcher
  }

  tags = "${var.tags}"
}