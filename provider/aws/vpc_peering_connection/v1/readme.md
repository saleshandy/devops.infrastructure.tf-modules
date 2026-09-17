*Example*

Cross-account VPC peering, requester side

```
module "hub_spoke_peering_connection" {
  source        = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/aws/vpc_peering_connection/v1"
  vpc_id        = module.hub_vpc.vpc_id
  peer_vpc_id   = "vpc-0123456789abcdef0" # Spoke VPC
  peer_owner_id = "123456789012"          # Optional, default: same account
  # peer_region = "us-east-1"             # Optional, default: same region

  tags = {
    Name : "hub-spoke-internal",
    Author : "Terraform",
  }
}

module "hub_spoke_peering_private_az_a" {
  source                    = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/aws/route/v1"
  route_table_id            = module.hub_route_table_private_az_a.route_table_id
  destination_cidr_block    = "10.9.0.0/16" # Spoke VPC CIDR
  is_vpc_peering_connection = true
  vpc_peering_connection_id = module.hub_spoke_peering_connection.vpc_peering_connection_id
}
```

Notes

- Cross-account or cross-region connections stay `pending-acceptance` until the peer accepts them; accept on the other side with `vpc_peering_connection_accepter/v1`. `auto_accept = true` only works when both VPCs are in the same account and region.
- Routes to a pending connection can be created, but they are blackholes until the connection is accepted.
- The two VPC CIDRs must not overlap.
- Peering routes and security groups are needed on both sides; this module creates only the connection.
