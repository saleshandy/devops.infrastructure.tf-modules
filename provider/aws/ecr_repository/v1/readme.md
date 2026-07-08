*Example*

```
module "example_production_ecr" {
    source = "./terraform-modules/provider/aws/ecr_repository"
    name = "example-production"
    image_tag_mutability = "MUTABLE"
    scan_on_push =true
}
```