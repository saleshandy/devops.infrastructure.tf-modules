*Example*

Cross-account private DNS, half one: the zone owner authorizes another account's VPC

```
# In the account that owns the zone (e.g. lynx)
module "example_milkyWay_private_zone_authorization" {
  source     = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/aws/route53_vpc_association_authorization/v1"
  zone_id    = module.example_rout53_private.route53_zone_zone_id
  vpc_id     = var.milkyWay_vpc_id
  vpc_region = var.aws_region
}
```

The other account then completes it with `route53_zone_association/v1`.

Notes

- A private hosted zone can only take a VPC from another account through this two-step handshake. Adding a foreign VPC to the zone's own `vpc` blocks fails.
- Order matters: this authorization has to exist before the other account can create its association, and the association has to be removed before this authorization can be destroyed. Two repos, so two applies in sequence each way.
- Deleting the authorization does not break an association that already exists — AWS only checks it at association time. It is safe to keep, and keeping it is what lets Terraform recreate the association later.
- Resolution also needs a network path between the VPCs (peering or Transit Gateway). Associating the zone only publishes the records; it does not create connectivity.
- Peering is not transitive: a VPC associated with the zone resolves the names, but only reaches the addresses it has a route to.
