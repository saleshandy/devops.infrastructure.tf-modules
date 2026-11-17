*Example*

S3 gateway endpoint on the private route tables, so S3 traffic stops going through the NAT gateway

```
module "example_vpc_endpoint_s3" {
  source       = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/aws/vpc_endpoint/v1"
  vpc_id       = module.example_vpc.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.s3"
  route_table_ids = [
    module.example_route_table_private_az_a.route_table_id,
    module.example_route_table_private_az_b.route_table_id,
  ]
  tags = {
    Name : "Example-s3",
    Author : "Terraform",
  }
}
```

Interface endpoint (e.g. ECR API)

```
module "example_vpc_endpoint_ecr_api" {
  source             = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/aws/vpc_endpoint/v1"
  vpc_id             = module.example_vpc.vpc_id
  service_name       = "com.amazonaws.${var.aws_region}.ecr.api"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = [module.example_private_subnet_az_a.subnet_id, module.example_private_subnet_az_b.subnet_id]
  security_group_ids = [module.example_vpce_sg.security_group_id]
}
```

Notes

- Gateway endpoints (S3, DynamoDB) cost nothing, so add them to every VPC that has a NAT gateway. NAT processing is $0.045/GB, and with no endpoint, S3 reads (Loki/Tempo chunks, ECR image layers) all go through it.
- A gateway endpoint only covers buckets in the **same region**. S3 traffic to other regions still goes through the NAT.
- After the switch, S3 sees the caller's private IP and the endpoint ID instead of the NAT's public IP, so bucket policies that allow `aws:SourceIp` = NAT EIP stop matching. Check bucket policies (yours and any third-party buckets you read) before adding the endpoint.
- Adding the route can reset S3 connections that are open at that moment. The SDKs retry, so this is normally invisible.
- Interface endpoints bill per AZ-hour (~$7.30/month per AZ) plus $0.01/GB. They only pay off when the traffic through them is large; ECR image pulls mostly fetch layers from S3, which the free S3 gateway endpoint already covers.
