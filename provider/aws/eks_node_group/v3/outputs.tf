output "eks_node_group_arn" {
  value = aws_eks_node_group.main.arn
  description = "The ARN of the EKS node group."
}

output "eks_node_group_id" {
  value = aws_eks_node_group.main.id
  description = "The ID of the EKS node group (Cluster name and Node Group name separated by a colon)."
}

output "eks_node_group_resources" {
  value = aws_eks_node_group.main.resources
  description = "List of objects containing information about the underlying resources of the EKS node group."
}

output "eks_node_group_autoscaling_groups" {
  value = aws_eks_node_group.main.autoscaling_groups
  description = "List of objects containing information about Auto Scaling Groups associated with the EKS node group."
}

output "eks_node_group_autoscaling_group_name" {
  value = aws_eks_node_group.main.autoscaling_groups[0].name
  description = "The name of the Auto Scaling Group in the EKS node group."
}

output "eks_node_group_remote_access_security_group_id" {
  value = aws_eks_node_group.main.remote_access_security_group_id
  description = "The identifier of the remote access EC2 security group for the EKS node group."
}

output "eks_node_group_status" {
  value = aws_eks_node_group.main.status
  description = "The status of the EKS node group."
}
