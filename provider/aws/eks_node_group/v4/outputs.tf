output "eks_node_group_arn"{
  value = "${aws_eks_node_group.main.arn}"
}

output "eks_node_group_resources"{
  value = "${aws_eks_node_group.main.resources}"
}
