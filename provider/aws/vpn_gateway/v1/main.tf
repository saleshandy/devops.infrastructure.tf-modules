resource "aws_vpn_gateway" "vpn_gw" {
  vpc_id = var.vpc_id

  tags            = var.tags
  amazon_side_asn = var.amazon_side_asn
}
