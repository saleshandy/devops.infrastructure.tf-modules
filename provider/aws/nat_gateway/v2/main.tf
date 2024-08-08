resource "aws_nat_gateway" "main" {
  allocation_id            = var.allocation_id
  subnet_id                = var.subnet_id
  secondary_allocation_ids = var.secondary_allocation_ids

  tags = var.tags
}
