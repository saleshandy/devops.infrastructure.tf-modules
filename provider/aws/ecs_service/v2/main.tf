resource "aws_ecs_service" "main" {
  name                    = var.name
  launch_type             = var.launch_type
  cluster                 = var.cluster
  task_definition         = var.task_definition
  desired_count           = var.desired_count
  enable_ecs_managed_tags = var.enable_ecs_managed_tags

  dynamic "load_balancer" {
    for_each = "${var.enableLoadBalancer}" ? ["true"] : []

    content {
      target_group_arn = var.target_group_arn
      container_name   = var.container_name
      container_port   = var.container_port
    }
  }

  dynamic "capacity_provider_strategy" {
    for_each = "${var.enable_fargate_spot}" ? ["true"] : []

    content {
      capacity_provider = "FARGATE_SPOT"
      weight                     = var.fargate_spot_weight
    }
  }

  dynamic "capacity_provider_strategy" {
    for_each = "${var.enable_fargate_spot}" ? ["true"] : []

    content {
      capacity_provider = "FARGATE"
      weight                     = var.fargate_weight
      base                       = var.fargate_base
    }
  }

  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = var.assign_public_ip
  }

  service_registries {
    registry_arn = var.registry_arn
  }

  tags = var.tags
  propagate_tags = var.propagate_tags
}
