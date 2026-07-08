resource "aws_ecs_cluster" "main" {
  name = "${var.name}"

	dynamic "setting" {
    for_each = "${var.enableContainerInsights}" ? ["true"] : []

    content {
      name  = "containerInsights"
    	value = "enabled"
    }
  }

  tags = "${var.tags}"
}