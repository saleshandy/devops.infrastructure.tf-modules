*Example*

EBS encryption by default with a customer-managed key

```
data "aws_caller_identity" "current" {}

module "example_ebs_kms_key" {
  source      = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/aws/kms_key/v1"
  description = "Customer-managed KMS key for Example EBS volumes"
  alias_name  = "example-ebs"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "EnableRootPermissions"
        Effect    = "Allow"
        Principal = { AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root" }
        Action    = "kms:*"
        Resource  = "*"
      },
      {
        # Same access the AWS-managed aws/ebs key gives: any principal in the account, only through EC2
        Sid       = "AllowEBSForAccountPrincipals"
        Effect    = "Allow"
        Principal = { AWS = "*" }
        Action    = ["kms:Encrypt", "kms:Decrypt", "kms:ReEncrypt*", "kms:GenerateDataKey*", "kms:CreateGrant", "kms:DescribeKey"]
        Resource  = "*"
        Condition = {
          StringEquals = {
            "kms:ViaService"    = "ec2.us-west-2.amazonaws.com"
            "kms:CallerAccount" = data.aws_caller_identity.current.account_id
          }
        }
      },
      {
        # EKS managed node groups and ASGs launch through Auto Scaling; without these, new instances fail to launch
        Sid       = "AllowAutoScalingServiceLinkedRole"
        Effect    = "Allow"
        Principal = { AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling" }
        Action    = ["kms:Encrypt", "kms:Decrypt", "kms:ReEncrypt*", "kms:GenerateDataKey*", "kms:DescribeKey"]
        Resource  = "*"
      },
      {
        Sid       = "AllowAutoScalingServiceLinkedRoleGrants"
        Effect    = "Allow"
        Principal = { AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling" }
        Action    = "kms:CreateGrant"
        Resource  = "*"
        Condition = { Bool = { "kms:GrantIsForAWSResource" = true } }
      }
    ]
  })
}

module "example_ebs_encryption_by_default" {
  source      = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/aws/ebs_encryption_by_default/v1"
  kms_key_arn = module.example_ebs_kms_key.kms_key_arn # Required unless use_aws_managed_key = true
}
```

To encrypt by default with the AWS-managed `aws/ebs` key instead:

```
module "example_ebs_encryption_by_default" {
  source              = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/aws/ebs_encryption_by_default/v1"
  use_aws_managed_key = true
}
```

Notes

- Both settings are account-wide per region. Declare this module once per account and region, in a single root module, or two roots will keep overwriting each other.
- Only volumes created afterwards are affected. Existing volumes keep their encryption state and key; replace them to re-encrypt (for EKS node groups, set `kms_key_id` on `eks_node_group/v6`, which rolls the nodes).
- The Auto Scaling service-linked role (`AWSServiceRoleForAutoScaling`) must exist before the key policy references it. It is created automatically with the first ASG or EKS managed node group in the account.
- Removing the module turns encryption by default off and resets the default key to aws/ebs.
