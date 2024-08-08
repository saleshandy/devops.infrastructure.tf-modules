*Example*

```
module "example_elasticache_subnet_group" {
  source = "./terraform-modules/provider/aws/elasticache_subnet_group/v1"
  name   = "example"
  subnet_ids = [
    "${module.example_private_subnet_az_a.subnet_id}",
    "${module.example_private_subnet_az_b.subnet_id}",
    "${module.example_private_subnet_az_c.subnet_id}"
  ]
  description = "test description"
}
```