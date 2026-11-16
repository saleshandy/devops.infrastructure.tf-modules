Same as v1, plus an optional `description` on each ingress and egress rule. Use it when a rule needs a label, or to bring a rule that was added in the AWS console (with a description) under Terraform without a diff. `security_groups` is optional and defaults to `[]`.

Moving an existing module block from v1 to v2 only changes `source`. The resource address stays the same, so no state move is needed. Rules without a `description` plan the same as they do on v1.

*Example*

```
module "example_security_group" {
  source      = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/aws/security_group/v2"
  name        = "example_security_group"
  description = "Security Group for RDS Example"
  vpc_id      = module.example_vpc.vpc_id
  ingress_rules = [
    {
      from     = 3306
      to       = 3306
      protocol = "TCP"
      cidr     = [module.example_vpc.vpc_cidr_block]
    },
    {
      from        = 3306
      to          = 3306
      protocol    = "TCP"
      cidr        = ["10.100.14.236/32"]
      description = "DMS replication instance"
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
