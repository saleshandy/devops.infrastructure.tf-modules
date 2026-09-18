resource "aws_route53_zone" "main" {
  name    = var.name
  comment = var.comment
  tags    = var.tags

  dynamic "vpc" {
    for_each = var.vpc_ids

    content {
      vpc_id = vpc.value
    }
  }

  lifecycle {
    # A zone treats its vpc blocks as the whole truth, so it deletes any association it did not
    # create — including one added from another account with aws_route53_zone_association, which is
    # the only way to attach a cross-account VPC. Without this, an unrelated apply silently drops
    # that association and the other account stops resolving the zone.
    #
    # The trade-off: Terraform no longer reconciles associations here at all, so changing vpc_ids
    # after creation has no effect. Add or remove VPCs with route53_zone_association instead.
    ignore_changes = [vpc]
  }
}
