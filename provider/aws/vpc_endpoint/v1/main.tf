# Gateway endpoints (S3, DynamoDB) attach to route tables and are free.
# Interface endpoints (ECR, STS, ...) place ENIs in subnets and bill per AZ-hour plus per GB.
resource "aws_vpc_endpoint" "main" {
  vpc_id            = var.vpc_id
  service_name      = var.service_name
  vpc_endpoint_type = var.vpc_endpoint_type

  route_table_ids     = var.vpc_endpoint_type == "Gateway" ? var.route_table_ids : null
  subnet_ids          = var.vpc_endpoint_type == "Interface" ? var.subnet_ids : null
  security_group_ids  = var.vpc_endpoint_type == "Interface" ? var.security_group_ids : null
  private_dns_enabled = var.vpc_endpoint_type == "Interface" ? var.private_dns_enabled : null

  policy = var.policy

  tags = var.tags
}
