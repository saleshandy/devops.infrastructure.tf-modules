*Example*

Helm chart installed by Terraform

```
provider "helm" {
  kubernetes = {
    host                   = module.example_eks_cluster.eks_endpoint
    cluster_ca_certificate = base64decode(module.example_eks_cluster.eks_cluster_certificate_authority_data)

    exec = {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["--region", var.aws_region, "eks", "get-token", "--cluster-name", module.example_eks_cluster.eks_cluster_name]
      env = {
        AWS_CONFIG_FILE             = ".aws/config"
        AWS_SHARED_CREDENTIALS_FILE = ".aws/credentials"
      }
    }
  }
}

module "example_aws_load_balancer_controller" {
  source        = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/helm/release/v1"
  name          = "aws-load-balancer-controller"
  namespace     = "kube-system"
  repository    = "https://aws.github.io/eks-charts"
  chart         = "aws-load-balancer-controller"
  chart_version = "3.5.0"

  values = [yamlencode({
    clusterName = module.example_eks_cluster.eks_cluster_name
    serviceAccount = {
      create      = true
      name        = "aws-load-balancer-controller"
      annotations = { "eks.amazonaws.com/role-arn" = module.example_alb_controller_role.iam_role_arn }
    }
  })]
}
```

Notes

- Needs the `helm` provider (v3 takes its cluster settings as the `kubernetes` attribute shown above). Whatever runs Terraform must reach the cluster API, which for a private EKS endpoint means being on the VPN or inside the VPC.
- Always pin `chart_version`; upgrade by changing it.
- `atomic` and `cleanup_on_fail` are on by default, so a failed install or upgrade rolls back instead of leaving half a release behind.
- Build `values` with `yamlencode()` rather than long `set` lists; `set` is applied after `values`.
- Helm does not upgrade CRDs that a chart ships when the release is upgraded. Watch for charts that need CRDs applied separately.
