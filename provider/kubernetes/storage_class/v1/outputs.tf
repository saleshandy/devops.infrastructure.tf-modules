output "storage_class_name" {
  value = kubernetes_storage_class_v1.main.metadata[0].name
}

output "provisioner" {
  value = kubernetes_storage_class_v1.main.storage_provisioner
}

output "reclaim_policy" {
  value = kubernetes_storage_class_v1.main.reclaim_policy
}
