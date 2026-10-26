*Example*

```
module "example_kms_key" {
  source      = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/aws/kms_key/v1"
  description = "Customer-managed KMS key for the example host root volume"
  alias_name  = "example-host"
}

module "example_instance" {
  source = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/aws/instance/v4"

  ami                    = "ami-0123456789abcdef0"
  instance_type          = "m7i.large"
  subnet_id              = module.example_private_subnet.subnet_id
  security_groups        = [module.example_sg.security_group_id]
  iam_instance_profile   = module.example_instance_profile.iam_instance_profile_name
  root_block_volume_size = 50

  # Optional. The key ARN, not the key id or alias
  root_block_volume_kms_key_id = module.example_kms_key.kms_key_arn

  # These are the defaults, shown for clarity
  metadata_http_tokens                 = "required"
  metadata_http_put_response_hop_limit = 1

  tags = {
    Name : "example-host",
    Author : "Terraform",
  }
}
```

Notes

- Same inputs as v3 plus the metadata and KMS ones, so moving from v3 is a change of `source`. The new output is `instance_private_ip`, for DNS records that point at the instance.
- **The metadata defaults are the point of this version.** `required` allows IMDSv2 only, which needs a PUT for a session token first, so a server tricked into fetching a URL (SSRF) cannot read the metadata service. A hop limit of 1 drops the token response before it crosses into a Docker bridge network, so containers on the host cannot fetch the instance role's credentials. Containers on host networking are not covered. Raise the hop limit to 2 only for a host whose containers need those credentials.
- **Moving an existing instance from v3 applies the metadata settings in place, without a replacement**, but `required` breaks anything on the host that still uses IMDSv1: old AWS SDKs and CLIs, or a plain `curl` to 169.254.169.254 without a token. The CloudWatch metric `MetadataNoToken` counts IMDSv1 calls per instance. Check it before switching, or set `metadata_http_tokens = "optional"` first.
- `root_block_volume_kms_key_id` must be the key ARN. AWS stores the ARN, so a key id or alias shows as a change on every plan, and a key change replaces the instance. Adding a key to an existing instance, or changing it, also replaces the instance: a root volume cannot be re-encrypted in place.
- Without a key, the volume is encrypted or not according to the account's EBS default (`aws/ebs` where encryption by default is on), and the module leaves it alone.
- The key policy must let whoever runs Terraform use the key, because EC2 creates its grant with the caller's permissions at launch. The kms_key/v1 default policy (account root, with IAM policies controlling use) does.
- `associate_elastic_ip` is still accepted so v3 callers keep working, but it does nothing; attach an Elastic IP with eip_association/v1.
