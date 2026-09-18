*Example*

StorageClass created by Terraform

```
provider "kubernetes" {
  host                   = module.example_eks_cluster.eks_endpoint
  cluster_ca_certificate = base64decode(module.example_eks_cluster.eks_cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["--region", var.aws_region, "eks", "get-token", "--cluster-name", module.example_eks_cluster.eks_cluster_name]
    env = {
      AWS_CONFIG_FILE             = ".aws/config"
      AWS_SHARED_CREDENTIALS_FILE = ".aws/credentials"
    }
  }
}

# Stateful data: the volume outlives its PVC
module "example_storage_class_ebs_retain" {
  source         = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/kubernetes/storage_class/v1"
  name           = "ebs-retain"
  reclaim_policy = "Retain"

  parameters = {
    type      = "gp3"
    encrypted = "true"
    kmsKeyId  = module.example_kms_key.kms_key_arn
  }
}

# Cluster default for everything else
module "example_storage_class_gp3" {
  source           = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/kubernetes/storage_class/v1"
  name             = "gp3"
  is_default_class = true

  parameters = {
    type      = "gp3"
    encrypted = "true"
    kmsKeyId  = module.example_kms_key.kms_key_arn
  }
}
```

Notes

- Needs the `kubernetes` provider. Whatever runs Terraform must reach the cluster API, which for a private EKS endpoint means being on the VPN or inside the VPC.
- EKS ships a `gp2` class using the in-tree `kubernetes.io/aws-ebs` provisioner. That provisioner was removed in Kubernetes 1.31, so on newer clusters it provisions nothing — a cluster needs at least one CSI-backed class before any PVC can bind.
- `reclaim_policy` is the important choice. `Retain` leaves the EBS volume behind when the PVC goes away, which is what you want for databases but means deleted volumes have to be cleaned up by hand. `Delete` is the provider default.
- `WaitForFirstConsumer` is the default binding mode on purpose: it provisions the volume in whichever AZ the pod is scheduled to, instead of creating it first and pinning the pod to that AZ.
- Most fields on a StorageClass are immutable, so changing `parameters`, `provisioner` or `reclaim_policy` replaces the object. Existing PVs keep the settings they were created with; only new volumes pick up the change.
- Setting `kmsKeyId` needs the EBS CSI driver's IAM role to be allowed `kms:CreateGrant`, `kms:GenerateDataKeyWithoutPlaintext` and `kms:Decrypt` on that key. With account-wide default EBS encryption already pointing at the key, `encrypted = "true"` alone is enough — naming the key is just explicit.
- Only one class per cluster may set `is_default_class`. Two defaults make PVCs without a `storageClassName` fail.
