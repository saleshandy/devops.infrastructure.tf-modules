resource "aws_service_discovery_service" "main" {
  name = var.name

  dns_config {
    namespace_id = var.namespace_id
    routing_policy = var.routing_policy

    dns_records {
      ttl  = var.dns_records_ttl
      type = var.dns_records_type
    }
  }

  tags = "${var.tags}"
}