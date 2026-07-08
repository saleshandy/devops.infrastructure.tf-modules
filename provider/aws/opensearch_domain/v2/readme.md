# AWS OpenSearch Domain Module v2

This module creates an AWS OpenSearch domain with support for:

## New Features in v2

### Coordinator Nodes
- `coordinator_node_enabled` - Enable dedicated coordinator nodes to offload coordination tasks
- `coordinator_node_count` - Number of coordinator nodes
- `coordinator_node_type` - Instance type for coordinator nodes (e.g., `c6g.large.search`)

### Warm Storage (UltraWarm)
- `warm_enabled` - Enable UltraWarm nodes for cost-effective storage
- `warm_count` - Number of UltraWarm nodes
- `warm_type` - Instance type for UltraWarm nodes (e.g., `ultrawarm1.medium.search`)

### Cold Storage
- `cold_storage_enabled` - Enable cold storage for long-term data retention at lower cost

### Custom Endpoints
- `custom_endpoint_enabled` - Enable custom domain endpoint
- `custom_endpoint` - Custom domain name (e.g., `search.example.com`)
- `custom_endpoint_certificate_arn` - ACM certificate ARN for the custom endpoint

## Usage Example

### Basic OpenSearch Domain
```hcl
module "opensearch" {
  source = "./provider/aws/opensearch_domain/v2"

  domain_name    = "my-search-domain"
  engine_version = "OpenSearch_2.11"
  
  instance_type  = "t3.small.search"
  instance_count = 2
  
  subnet_ids         = ["subnet-xxx", "subnet-yyy"]
  security_group_ids = ["sg-xxx"]
  
  tags = {
    Environment = "production"
    Team        = "platform"
  }
}
```

### With Warm Storage and Cold Storage
```hcl
module "opensearch_with_warm_cold" {
  source = "./provider/aws/opensearch_domain/v2"

  domain_name    = "my-search-domain"
  engine_version = "OpenSearch_2.11"
  
  # Data nodes
  instance_type  = "r6g.xlarge.search"
  instance_count = 3
  
  # UltraWarm nodes for warm storage
  warm_enabled = true
  warm_count   = 2
  warm_type    = "ultrawarm1.medium.search"
  
  # Cold storage for long-term retention
  cold_storage_enabled = true
  
  subnet_ids         = ["subnet-xxx", "subnet-yyy", "subnet-zzz"]
  security_group_ids = ["sg-xxx"]
  
  zone_awareness_enabled   = true
  availability_zone_count  = 3
}
```

### With Custom Endpoint
```hcl
module "opensearch_custom_endpoint" {
  source = "./provider/aws/opensearch_domain/v2"

  domain_name    = "my-search-domain"
  engine_version = "OpenSearch_2.11"
  
  instance_type  = "t3.small.search"
  instance_count = 1
  
  # Custom endpoint configuration
  custom_endpoint_enabled         = true
  custom_endpoint                 = "search.example.com"
  custom_endpoint_certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/xxx"
  
  subnet_ids         = ["subnet-xxx"]
  security_group_ids = ["sg-xxx"]
}
```

### With Dedicated Master Nodes and Coordinator Nodes
```hcl
module "opensearch_with_masters_coordinators" {
  source = "./provider/aws/opensearch_domain/v2"

  domain_name    = "my-search-domain"
  engine_version = "OpenSearch_2.11"
  
  # Data nodes
  instance_type  = "r6g.xlarge.search"
  instance_count = 6
  
  # Dedicated master nodes
  dedicated_master_enabled = true
  dedicated_master_type    = "c6g.large.search"
  dedicated_master_count   = 3
  
  # Coordinator nodes to handle client requests
  coordinator_node_enabled = true
  coordinator_node_type    = "c6g.large.search"
  coordinator_node_count   = 2
  
  zone_awareness_enabled   = true
  availability_zone_count  = 3
  
  subnet_ids         = ["subnet-xxx", "subnet-yyy", "subnet-zzz"]
  security_group_ids = ["sg-xxx"]
}
```

## Requirements

- Terraform >= 0.13
- AWS Provider >= 4.0

## Important Notes

1. **Coordinator Nodes**: Dedicated coordinator nodes handle cluster management and client requests, offloading this work from data nodes. Useful for large clusters with heavy indexing/search workloads.
2. **Cold Storage Requirements**: Cold storage requires UltraWarm to be enabled
3. **UltraWarm Instance Types**: Must use `ultrawarm1.medium.search` or `ultrawarm1.large.search`
4. **Custom Endpoints**: Requires a valid ACM certificate in the same region
5. **Zone Awareness**: When enabled with 3 AZs, instance count must be a multiple of 3

## Outputs

- `domain_id` - Unique identifier for the domain
- `domain_name` - Name of the OpenSearch domain
- `arn` - ARN of the domain
- `endpoint` - Domain endpoint for API requests
- `dashboard_endpoint` - OpenSearch Dashboards endpoint
