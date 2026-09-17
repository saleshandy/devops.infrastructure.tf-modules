*Example*

Cross-account VPC peering, accepter side

```
# Look the connection up instead of hardcoding its pcx- ID
data "aws_vpc_peering_connection" "spoke_hub" {
  owner_id    = "123456789012"         # Requester account
  vpc_id      = "vpc-0fedcba9876543210" # Requester VPC
  peer_vpc_id = module.spoke_vpc.vpc_id # This (accepter) VPC

  filter {
    name   = "status-code"
    values = ["pending-acceptance", "active"]
  }
}

module "spoke_hub_peering_accepter" {
  source                    = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/aws/vpc_peering_connection_accepter/v1"
  vpc_peering_connection_id = data.aws_vpc_peering_connection.spoke_hub.id

  tags = {
    Name : "spoke-hub-internal",
    Author : "Terraform",
  }
}

module "spoke_hub_peering_private_az_a" {
  source                    = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/aws/route/v1"
  route_table_id            = module.spoke_route_table_private_az_a.route_table_id
  destination_cidr_block    = "10.100.0.0/16" # Hub VPC CIDR
  is_vpc_peering_connection = true
  vpc_peering_connection_id = module.spoke_hub_peering_accepter.vpc_peering_connection_id
}
```

Notes

- Apply the requester side (`vpc_peering_connection/v1`) first: the lookup fails until the connection exists.
- Tags set here apply to the accepter account's view of the connection; each account tags it separately.
- Destroying this module does not delete the peering connection, it only stops Terraform tracking the acceptance. Delete the connection from the requester side.
