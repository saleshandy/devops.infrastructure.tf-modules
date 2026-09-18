# Run in the account that owns the VPC. For a zone in another account, that account must first
# have created a matching route53_vpc_association_authorization.
resource "aws_route53_zone_association" "main" {
  zone_id    = var.zone_id
  vpc_id     = var.vpc_id
  vpc_region = var.vpc_region
}
