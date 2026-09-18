# Run in the account that OWNS the hosted zone. Authorizes a VPC in another account to be
# associated with it; the other account then creates the association itself.
resource "aws_route53_vpc_association_authorization" "main" {
  zone_id    = var.zone_id
  vpc_id     = var.vpc_id
  vpc_region = var.vpc_region
}
