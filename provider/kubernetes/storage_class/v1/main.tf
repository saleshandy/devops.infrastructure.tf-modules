terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

resource "kubernetes_storage_class_v1" "main" {
  metadata {
    name   = var.name
    labels = var.labels

    # Exactly one StorageClass in a cluster may be the default
    annotations = merge(
      var.annotations,
      var.is_default_class ? { "storageclass.kubernetes.io/is-default-class" = "true" } : {},
    )
  }

  storage_provisioner    = var.provisioner
  parameters             = var.parameters
  reclaim_policy         = var.reclaim_policy
  volume_binding_mode    = var.volume_binding_mode
  allow_volume_expansion = var.allow_volume_expansion
  mount_options          = var.mount_options
}
