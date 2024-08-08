*Example*

EKS Node Group

```
module "example_eks_node_group_default" {
  source       = "./terraform-modules/provider/aws/eks_node_group/v1"
  cluster_name = module.example_eks_cluster.eks_cluster_name

  node_group_name = "example_eks_node_group_default"
  node_role_arn   = module.example_eks_node_group_role.iam_role_arn

  subnet_ids = [
    "${module.example_private_subnet_az_a.subnet_id}",
    "${module.example_private_subnet_az_b.subnet_id}",
    "${module.example_private_subnet_az_c.subnet_id}"
  ]

  ami_type  = "AL2_x86_64" #Default : AL2_x86_64
  disk_size = 50           # Default: 20Gb
  # instance_types = []  #List of instance types
  capacity_type = "ON_DEMAND" # values: ON_DEMAND, SPOT

  # Scaling_config
  desired_size = 2 #Must be at least 1 for coredns to work
  max_size     = 10
  min_size     = 1 #Must be at least 1 for coredns to work


  # Remote Access for nodes if ssh enable required
  ec2_ssh_key               = module.example_eks_node_group_ssh_key.key_name
  source_security_group_ids = ["${module.example_eks_node_group_security_group.security_group_id}"]


  # Addons part (optional) check supported version by cluster
  # aws eks describe-addon-version --addon-name <addon name>
  addon_create_vpc_cni  = true
  addon_vpc_cni_version = "v1.10.1-eksbuild.1"

  addon_create_kube_proxy  = true
  addon_kube_proxy_version = "v1.21.2-eksbuild.2"

  # change to true after creation of one node
  addon_create_coredns  = true
  addon_coredns_version = "v1.8.4-eksbuild.1"
}
```

Role

```
module "example_eks_node_group_role" {
  source = "./terraform-modules/provider/aws/iam_role/v1"
  name   = "example_eks_node_group_role"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ]
}

```


Security Group
```
module "example_security_group" {
  source      = "./terraform-modules/provider/aws/security_group/v1"
  name        = "example_security_group"
  description = "Security Group for RDS Example"
  vpc_id      = module.example_vpc.vpc_id
  ingress_rules = [
    {
      from     = 22
      to       = 22
      protocol = "TCP"
      cidr     = ["${module.example_vpc.vpc_cidr_block}"]
    }
  ]

  egress_rules = [
    {
      from     = 0
      to       = 0
      protocol = "-1"
      cidr     = ["0.0.0.0/0"]
    }
  ]
}
```

SSH Key
```
module "example_ssh_key" {
  source     = "./terraform-modules/provider/aws/key_pair/v1"
  key_name   = "eks_node_t3"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPyciJIRAXVIzXSxEx57LYxwbuVAql9nRuFFWyk63U53 example@hkpanchani.dev"
}
```