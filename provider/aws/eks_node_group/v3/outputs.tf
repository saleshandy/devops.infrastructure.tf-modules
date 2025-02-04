output "eks_node_group_arn" {
  value       = aws_eks_node_group.main.arn
  description = "The ARN of the EKS node group."
}

output "eks_node_group_id" {
  value       = aws_eks_node_group.main.id
  description = "The ID of the EKS node group (Cluster name and Node Group name separated by a colon)."
}
