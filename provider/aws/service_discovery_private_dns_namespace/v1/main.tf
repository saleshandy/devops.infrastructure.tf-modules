resource "aws_service_discovery_private_dns_namespace" "main" {
  name        = "${var.name}"
  vpc         = "${var.vpc}"

  tags = "${var.tags}"
}