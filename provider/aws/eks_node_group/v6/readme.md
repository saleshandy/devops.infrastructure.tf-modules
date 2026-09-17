*Example*

EKS Node Group

```
module "example_eks_node_group_default" {
  source       = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/aws/eks_node_group/v6"
  cluster_name = module.example_eks_cluster.eks_cluster_name

  node_group_name = "example-eks-node-group-default"
  node_role_arn   = module.example_eks_node_group_role.iam_role_arn

  subnet_ids = [
    module.example_private_subnet_az_a.subnet_id,
    module.example_private_subnet_az_b.subnet_id,
  ]

  ami_type       = "AL2023_ARM_64_STANDARD" # Default: AL2023_x86_64_STANDARD
  disk_size      = 50                       # Default: 20Gb
  instance_types = ["t4g.large"]
  capacity_type  = "ON_DEMAND"              # values: ON_DEMAND, SPOT
  kms_key_id     = module.example_ebs_kms_key.kms_key_arn # Optional, default: account default EBS key

  # Scaling_config
  desired_size = 2
  max_size     = 4
  min_size     = 2

  taints = {
    application = {
      key    = "application"
      value  = "example"
      effect = "NO_SCHEDULE"
    }
  }

  labels = {
    application : "example"
  }

  # Applied to the node group, launch template and every instance, volume and ENI it launches
  tags = {
    Name : "example-eks-node-group-default",
    Author : "Terraform",
  }

  # Addons part (optional) check supported version by cluster
  # aws eks describe-addon-versions --kubernetes-version <version> --addon-name <addon name>
  addon_create_vpc_cni  = true
  addon_vpc_cni_version = "v1.23.1-eksbuild.1"
}
```

Changes from v5

- Node tagging is native: the module owns an `aws_launch_template` whose `tag_specifications` apply `tags` to every instance, root volume and primary ENI at launch. The `null_resource` + AWS CLI ASG tagging (which used the shell's ambient AWS credentials and the deprecated `aws_region.name`) is removed, so the `null` provider is no longer needed.
- No external module dependency (v5 pulled `launch_template` from `github.com/opsonspot/terraform-modules`).
- The node group tracks the launch template's latest version, so changing `tags`, `disk_size` or `kms_key_id` rolls the nodes (respecting `max_unavailable_percentage`, default 1 = one node at a time).
- `kms_key_id` (optional) encrypts the root volume with a customer-managed key. Its key policy must allow the Auto Scaling service-linked role, or new nodes fail to launch; see `ebs_encryption_by_default/v1` for a policy.
- IMDS defaults to IMDSv2 only (`metadata_http_tokens = "required"`) with hop limit 2 so pods can still reach IMDS. Set `metadata_http_tokens = "optional"` for workloads using very old AWS SDKs.
- `ec2_ssh_key` is set as the launch template key pair; `source_security_group_ids` / `remote_access` are dropped (EKS does not allow `remote_access` together with a launch template).
- Defaults to `AL2023_x86_64_STANDARD` (AL2 AMIs are end of life).
