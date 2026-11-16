Same inputs as v2, but the static website and CORS settings are separate `aws_s3_bucket_website_configuration` and `aws_s3_bucket_cors_configuration` resources. The inline `website` and `cors_rule` blocks on `aws_s3_bucket` are deprecated in the AWS provider and print a warning on every plan.

Two differences from v2: `allowed_methods` defaults to `["GET"]`, since the separate CORS resource needs upper-case methods, and versioning now references the bucket resource instead of the variable.

*Example*

```
module "example_s3_bucket" {
  source = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/aws/s3_bucket/v3"
  bucket = "example-bucket-name"

  static_website = true
  index_document = "index.html"
  error_document = "index.html"
}
```

*Moving a bucket from v2*

Change `source` to v3. `aws_s3_bucket.main` and `aws_s3_bucket_versioning.main` keep their addresses. If the bucket has `static_website` or `cors_rule` turned on, import the existing settings with a one-time block in the root module, so Terraform adopts them instead of rewriting them:

```
import {
  to = module.example_s3_bucket.aws_s3_bucket_website_configuration.main[0]
  id = "example-bucket-name"
}

import {
  to = module.example_s3_bucket.aws_s3_bucket_cors_configuration.main[0]
  id = "example-bucket-name"
}
```
