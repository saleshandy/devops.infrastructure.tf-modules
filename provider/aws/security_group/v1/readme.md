*Example*

```
module "example_security_group" {
  source      = "./terraform-modules/provider/aws/security_group/v1"
  name        = "example_security_group"
  description = "Security Group for RDS Example"
  vpc_id      = module.example_vpc.vpc_id
  ingress_rules = [
    {
      from     = 22
      to       = 22
      protocol = "TCP"
      cidr     = ["${module.example_vpc.vpc_cidr_block}"]
    }
  ]

  egress_rules = [
    {
      from     = 0
      to       = 0
      protocol = "-1"
      cidr     = ["0.0.0.0/0"]
    }
  ]
}
```