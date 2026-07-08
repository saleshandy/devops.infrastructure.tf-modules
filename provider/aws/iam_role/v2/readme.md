# AWS IAM Role Module - v2

Terraform module to create an AWS IAM role.

## Usage

```hcl
module "iam_role" {
  source = "github.com/opsonspot/terraform-modules/provider/aws/iam_role/v2"

  name = "my-application-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name        = "my-application-role"
    Environment = "production"
  }
}

# Attach policies using aws_iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "policy" {
  role       = module.iam_role.iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}
```

## Outputs

```hcl
output "role_arn" {
  value = module.iam_role.iam_role_arn
}

output "role_name" {
  value = module.iam_role.iam_role_name
}
```

## Note

This v2 module removes the deprecated `managed_policy_arns` parameter. Use `aws_iam_role_policy_attachment` resources to attach policies to the role instead.

