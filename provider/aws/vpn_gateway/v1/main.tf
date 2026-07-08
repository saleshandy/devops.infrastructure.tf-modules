resource "aws_vpn_gateway" "main" {
  vpc_id = var.vpc_id

  tags            = var.tags
  amazon_side_asn = var.amazon_side_asn
}
