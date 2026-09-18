output "release_name" {
  value = helm_release.main.name
}

output "namespace" {
  value = helm_release.main.namespace
}

output "chart_version" {
  value = helm_release.main.version
}

output "status" {
  value = helm_release.main.status
}

output "metadata" {
  value = helm_release.main.metadata
}
