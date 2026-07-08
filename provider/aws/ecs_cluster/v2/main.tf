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

resource "aws_ecs_cluster_capacity_providers" "main" {
  cluster_name = "${var.name}"
  capacity_providers = "${var.capacity_providers}"
}