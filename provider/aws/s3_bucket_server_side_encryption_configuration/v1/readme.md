*Example*

Default bucket encryption with a customer-managed KMS key

```
module "example_loki_s3_bucket_encryption" {
  source      = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/aws/s3_bucket_server_side_encryption_configuration/v1"
  bucket      = module.example_loki_s3_bucket.s3_bucket_bucket
  kms_key_arn = module.example_kms_key.kms_key_arn # Optional, default: SSE-S3 (AES256)
}
```

Notes

- Only new objects are affected. Existing objects keep their encryption until they are rewritten (e.g. copied in place).
- Buckets that receive ALB/ELB access logs must stay on SSE-S3 (leave `kms_key_arn` null): log delivery does not support SSE-KMS.
- Everything that reads or writes the bucket must be allowed to use the key, through the key policy (for example `kms:ViaService` = `s3.<region>.amazonaws.com` for account principals) or IAM.
- `bucket_key_enabled` (default true) makes S3 use a bucket-level data key, which reduces KMS API calls and cost.
