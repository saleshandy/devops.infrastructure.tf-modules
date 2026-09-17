*Example*

ECR repository encrypted with a customer-managed KMS key

```
module "example_api_ecr" {
  source               = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/aws/ecr_repository/v2"
  name                 = "example-api"
  image_tag_mutability = "MUTABLE"                           # Default: MUTABLE
  scan_on_push         = true                                # Default: true
  kms_key_arn          = module.example_kms_key.kms_key_arn  # Optional, default: AES256

  tags = {
    Name : "example-api",
    Author : "Terraform",
  }
}
```

Changes from v1

- `kms_key_arn` (optional) encrypts images with a customer-managed KMS key instead of AES256. The key policy must allow ECR use, e.g. `kms:ViaService` = `ecr.<region>.amazonaws.com` for account principals.
- `force_delete` (default false) allows deleting or replacing a repository that still contains images.
- Typed variables; `image_tag_mutability` defaults to MUTABLE and `scan_on_push` to true.
- New output `ecr_repository_arn`.

Notes

- Encryption can't be changed after creation. Moving an existing repository from v1 to v2 with a KMS key, or changing `kms_key_arn`, replaces the repository and deletes its images.
- A replaced repository takes its lifecycle policy with it, while Terraform still has the policy in state. Replace the `ecr_lifecycle_policy` resources in the same apply (`terraform apply -replace=module.<name>_lifecycle.aws_ecr_lifecycle_policy.main`), or apply twice.
