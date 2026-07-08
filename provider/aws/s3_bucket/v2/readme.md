*Example*

```
module "example_s3_bucket" {
  source = "./terraform-modules/provider/aws/s3_bucket"
  bucket = "example-bucket-name"
}
```