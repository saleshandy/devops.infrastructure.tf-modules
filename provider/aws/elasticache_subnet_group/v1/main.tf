resource "aws_elasticache_subnet_group" "main" {
  name        = "${var.name}"
  subnet_ids = "${var.subnet_ids}"
  description = "${var.description}"
  tags = "${var.tags}"
}