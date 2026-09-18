*Example*

An EKS managed addon on its own, rather than bolted onto a node group

```
module "example_metrics_server" {
  source        = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/aws/eks_addon/v1"
  depends_on    = [module.example_eks_node_group_default]
  cluster_name  = module.example_eks_cluster.eks_cluster_name
  addon_name    = "metrics-server"
  addon_version = "v0.9.0-eksbuild.11"
}

# An addon that calls AWS APIs needs an IRSA role
module "example_ebs_csi_driver" {
  source                   = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/aws/eks_addon/v1"
  cluster_name             = module.example_eks_cluster.eks_cluster_name
  addon_name               = "aws-ebs-csi-driver"
  addon_version            = "v1.66.0-eksbuild.1"
  service_account_role_arn = module.example_ebs_csi_role.iam_role_arn
}
```

Notes

- Addons are cluster-scoped, so they belong here rather than on a node group. `eks_node_group/v6` can also create the four core addons through `addon_create_*` flags, which is convenient when a cluster is first built but means an addon's lifecycle is tied to one node group. Prefer this module for anything added later.
- Addons whose pods must be scheduled somewhere need `depends_on` a node group, or the addon is created while nothing can run it and reports DEGRADED until a node appears.
- Always pin `addon_version`. Leaving it null takes whatever AWS defaults to for the cluster's Kubernetes version, and that default moves.
- `resolve_conflicts_on_update` defaults to `PRESERVE` so an upgrade keeps fields changed in-cluster. Use `OVERWRITE` deliberately when you want AWS's manifest to win — for example after hand-patching an addon to get an upgrade unstuck.
- `preserve_on_delete` leaves the Kubernetes objects behind when the addon is removed from EKS, which is how you hand an addon over to a Helm chart without an outage.
- `configuration_values` is a JSON string, not an object. Build it with `jsonencode()`; what each addon accepts comes from `aws eks describe-addon-configuration`.
