*Example*

Private hosted zone that can also take VPCs from other accounts

```
module "example_rout53_private" {
  source  = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/aws/route53_zone/v2"
  name    = "trulyinbox.example"
  comment = "Example private zone"
  vpc_ids = [module.example_vpc.vpc_id]

  tags = {
    Author : "Terraform",
  }
}
```

Notes

- **The difference from v1** is `lifecycle { ignore_changes = [vpc] }`. Without it a zone deletes any VPC association it did not create itself, so an association added from another account with `route53_zone_association/v1` disappears on the next unrelated `apply` and that account silently stops resolving the zone.
- The trade-off is that Terraform no longer reconciles associations here. `vpc_ids` applies on create only; after that, add or remove VPCs with `route53_zone_association/v1` (plus `route53_vpc_association_authorization/v1` in this account when the VPC belongs to another one).
- Upgrading an existing zone from v1 is a source change only — the resource address does not move, so no `moved` block and no replacement. The first plan afterwards stops showing the VPC drift.
- A zone with no `vpc_ids` is public.
