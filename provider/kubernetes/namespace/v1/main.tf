terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

resource "kubernetes_namespace_v1" "main" {
  metadata {
    name        = var.name
    labels      = var.labels
    annotations = var.annotations
  }

  # Argo CD and controllers add their own labels and annotations to namespaces they manage;
  # ignoring them keeps Terraform from fighting the cluster over fields it does not own.
  lifecycle {
    ignore_changes = [
      metadata[0].labels,
      metadata[0].annotations,
    ]
  }

  timeouts {
    delete = var.delete_timeout
  }
}
