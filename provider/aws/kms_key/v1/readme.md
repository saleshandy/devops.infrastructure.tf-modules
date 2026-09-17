*Example*

KMS Key

```
module "example_recordings_kms_key" {
  source      = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/aws/kms_key/v1"
  description = "Customer-managed KMS key for example call recordings"
  alias_name  = "example-recordings" # Optional, the alias/ prefix is added if missing

  # Optional. Null applies the AWS default key policy (account root, IAM policies control use)
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "EnableRootPermissions"
        Effect    = "Allow"
        Principal = { AWS = "arn:aws:iam::123456789012:root" }
        Action    = "kms:*"
        Resource  = "*"
      },
      {
        Sid       = "AllowServiceEncryptDecrypt"
        Effect    = "Allow"
        Principal = { AWS = module.example_eks_node_group_role.iam_role_arn }
        Action    = ["kms:Encrypt", "kms:Decrypt", "kms:ReEncrypt*", "kms:GenerateDataKey*", "kms:DescribeKey"]
        Resource  = "*"
      }
    ]
  })

  tags = {
    Name : "example-recordings",
    Author : "Terraform",
  }
}
```

Notes

- Automatic rotation is on by default (every 365 days). The key ID and ARN do not change on rotation, so nothing that references the key needs updating.
- Keep a root statement like `EnableRootPermissions` in custom policies. It is what lets IAM policies and admins manage the key; KMS rejects a policy that would lock the caller out.
- Destroying the module schedules the key for deletion after `deletion_window_in_days` (default 30). Data encrypted with the key is unrecoverable once the window passes; cancel with `aws kms cancel-key-deletion` inside the window.
- For a default EBS encryption key, see `ebs_encryption_by_default/v1`.
