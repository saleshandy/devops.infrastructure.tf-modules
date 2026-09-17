output "eks_node_group_arn" {
  value = aws_eks_node_group.main.arn
}

output "eks_node_group_name" {
  value = aws_eks_node_group.main.node_group_name
}

output "eks_node_group_resources" {
  value = aws_eks_node_group.main.resources
}

output "launch_template_id" {
  value = aws_launch_template.main.id
}

output "launch_template_latest_version" {
  value = aws_launch_template.main.latest_version
}
