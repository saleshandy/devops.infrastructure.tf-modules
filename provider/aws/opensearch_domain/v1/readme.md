# AWS OpenSearch Domain Module - v1

Terraform module to create an AWS OpenSearch domain.

## Usage

```hcl
module "opensearch" {
  source = "github.com/opsonspot/terraform-modules/provider/aws/opensearch_domain/v1"

  domain_name    = "my-opensearch-domain"
  engine_version = "OpenSearch_2.11"

  instance_type  = "t3.small.search"
  instance_count = 2

  zone_awareness_enabled   = true
  availability_zone_count  = 2

  ebs_enabled = true
  volume_type = "gp3"
  volume_size = 20

  subnet_ids         = ["subnet-12345678", "subnet-87654321"]
  security_group_ids = ["sg-12345678"]

  encrypt_at_rest_enabled        = true
  node_to_node_encryption_enabled = true
  enforce_https                   = true

  access_policies = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Action   = "es:*"
        Resource = "arn:aws:es:us-east-1:123456789012:domain/my-opensearch-domain/*"
      }
    ]
  })

  tags = {
    Name        = "my-opensearch-domain"
    Environment = "production"
  }
}
```

## Outputs

```hcl
output "opensearch_endpoint" {
  value = module.opensearch.endpoint
}

output "opensearch_dashboard_endpoint" {
  value = module.opensearch.dashboard_endpoint
}
```

