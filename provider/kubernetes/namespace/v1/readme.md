*Example*

Namespace created by Terraform, so it exists before Argo CD syncs an Application into it

```
module "example_namespace_clickhouse" {
  source = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/kubernetes/namespace/v1"
  name   = "clickhouse"
}
```

Notes

- Needs the `kubernetes` provider. Whatever runs Terraform must reach the cluster API, which for a private EKS endpoint means being on the VPN or inside the VPC.
- An Argo CD Application whose destination namespace does not exist fails to sync with `namespaces "<name>" not found` unless the Application sets `CreateNamespace=true`. Creating it here instead keeps the namespace owned by Terraform and out of the Application's sync, so deleting the Application never deletes the namespace.
- Labels and annotations are applied at creation and then ignored, because Argo CD, service meshes and Pod Security admission all write their own onto namespaces they manage. Without that, every `plan` would try to strip them.
- Deleting a namespace deletes everything inside it. A delete that hangs is almost always a finalizer on a resource in the namespace, not a slow API — raise `delete_timeout` only once you know what is holding it.
