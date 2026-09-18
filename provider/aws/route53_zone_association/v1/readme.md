*Example*

Cross-account private DNS, half two: the VPC owner joins a zone in another account

```
# In the account that owns the VPC (e.g. milkyway), after the zone owner has authorized it
module "example_lynx_private_zone_association" {
  source  = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/aws/route53_zone_association/v1"
  zone_id = var.lynx_private_zone_id
  vpc_id  = module.example_vpc.vpc_id
}
```

Also works same-account, though a zone's own `vpc` blocks are usually simpler there.

Notes

- Cross-account needs `route53_vpc_association_authorization/v1` applied in the zone's account first, or this fails as not authorized.
- Destroy order is the reverse of create: remove this association before the authorization on the other side.
- Association publishes the zone's records to the VPC's resolver. It does not create a network path — the VPCs still need peering or a Transit Gateway, and peering is not transitive.
- A VPC may be associated with several private zones, but overlapping names across them resolve unpredictably. Keep one zone per name.
