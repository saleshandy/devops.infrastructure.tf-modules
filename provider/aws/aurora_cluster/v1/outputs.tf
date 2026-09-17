output "cluster_identifier" {
  value = aws_rds_cluster.main.cluster_identifier
}

output "cluster_arn" {
  value = aws_rds_cluster.main.arn
}

output "cluster_resource_id" {
  value = aws_rds_cluster.main.cluster_resource_id
}

output "endpoint" {
  description = "Writer endpoint"
  value       = aws_rds_cluster.main.endpoint
}

output "reader_endpoint" {
  value = aws_rds_cluster.main.reader_endpoint
}

output "port" {
  value = aws_rds_cluster.main.port
}

output "master_user_secret_arn" {
  description = "Secrets Manager secret holding the master user credentials"
  value       = try(aws_rds_cluster.main.master_user_secret[0].secret_arn, null)
}

output "instance_identifiers" {
  value = [for i in aws_rds_cluster_instance.main : i.identifier]
}
