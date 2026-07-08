resource "aws_lb" "main" {
  name               = var.name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = var.security_groups
  subnets            = var.subnets

  idle_timeout = var.idle_timeout

  dynamic "access_logs" {
    for_each = var.access_logs_bucket != null ? ["true"] : []

    content {
      enabled = true
      bucket  = var.access_logs_bucket
    }
  }

  enable_deletion_protection = var.enable_deletion_protection

  tags = var.tags
}
