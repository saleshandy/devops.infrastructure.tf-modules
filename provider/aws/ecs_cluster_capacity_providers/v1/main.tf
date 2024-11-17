resource "aws_ecs_cluster_capacity_providers" "main" {
  cluster_name = var.cluster

  capacity_providers = var.capacity_providers

  dynamic "default_capacity_provider_strategy" {
    for_each = var.capacity_provider_strategy != null ? [var.capacity_provider_strategy] : []
    content {
      base              = each.value.base
      weight            = each.value.weight
      capacity_provider = each.value.capacity_provider
    }
  }
}
