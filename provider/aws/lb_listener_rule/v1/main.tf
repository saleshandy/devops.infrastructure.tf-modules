resource "aws_lb_listener_rule" "main" {
  listener_arn = var.listener_arn
  priority     = var.priority

  action {
    type             = var.action_type
    target_group_arn = var.action_target_group_arn
  }

  condition {
    dynamic "host_header" {
			for_each = var.condition_host_header != null ? ["true"] : []

			content {
				values = var.condition_host_header
			}
    }

    dynamic "path_pattern" {
			for_each = var.condition_path_pattern != null ? ["true"] : []

			content {
				values = var.condition_path_pattern
			}
    }
  }
}
