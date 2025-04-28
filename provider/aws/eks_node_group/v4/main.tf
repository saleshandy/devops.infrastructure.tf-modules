resource "aws_eks_node_group" "main" {
  cluster_name = var.cluster_name

  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn

  subnet_ids = var.subnet_ids

  ami_type       = var.ami_type
  disk_size      = var.disk_size
  instance_types = var.instance_types
  capacity_type  = var.capacity_type

  labels = var.labels

  release_version = var.ami_release_version

  tags = var.tags

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size

  }

  dynamic "remote_access" {
    for_each = "${var.ec2_ssh_key}" != null && "${var.ec2_ssh_key}" != "" ? ["true"] : []
    content {
      ec2_ssh_key               = var.ec2_ssh_key
      source_security_group_ids = var.source_security_group_ids
    }
  }

  dynamic "taint" {
    for_each = var.taints

    content {
      key    = taint.value.key
      value  = try(taint.value.value, null)
      effect = taint.value.effect
    }
  }

  # Optional: Allow external changes without Terraform plan difference
  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }
}


# Add-on addition in EKS cluster
resource "aws_eks_addon" "vpc_cni" {
  count = "${var.addon_create_vpc_cni}" ? 1 : 0

  cluster_name                = var.cluster_name
  addon_name                  = "vpc-cni"
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"
  addon_version               = var.addon_vpc_cni_version

}

resource "aws_eks_addon" "kube_proxy" {
  count = "${var.addon_create_kube_proxy}" ? 1 : 0

  cluster_name                = var.cluster_name
  addon_name                  = "kube-proxy"
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"
  addon_version               = var.addon_kube_proxy_version

}

resource "aws_eks_addon" "coredns" {
  count = "${var.addon_create_coredns}" ? 1 : 0

  depends_on = [aws_eks_node_group.main]

  cluster_name                = var.cluster_name
  addon_name                  = "coredns"
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"
  addon_version               = var.addon_coredns_version
}

resource "aws_eks_addon" "ebs_csi_driver" {
  count = "${var.addon_create_ebs_csi_driver}" ? 1 : 0

  depends_on = [aws_eks_node_group.main]

  cluster_name                = var.cluster_name
  addon_name                  = "aws-ebs-csi-driver"
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"
  addon_version               = var.addon_ebs_csi_driver_version
}

resource "aws_eks_addon" "aws_guardduty_agent" {
  count = "${var.addon_create_aws_guardduty_agent}" ? 1 : 0

  depends_on = [aws_eks_node_group.main]

  cluster_name                = var.cluster_name
  addon_name                  = "aws-guardduty-agent"
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"
  addon_version               = var.addon_aws_guardduty_agent_version
}

data "aws_autoscaling_groups" "eks_asgs" {
  depends_on = [aws_eks_node_group.main]
}

resource "aws_autoscaling_group_tag" "multiple_tags" {
  depends_on = [aws_eks_node_group.main]

  for_each = {
    for asg_name in data.aws_autoscaling_groups.eks_asgs.names :
    for tag_key, tag_value in var.tags :
    "${asg_name}-${tag_key}" => {
      asg_name  = asg_name
      tag_key   = tag_key
      tag_value = tag_value
    }
    if contains(asg_name, var.node_group_name)
  }

  autoscaling_group_name = each.value.asg_name

  tag {
    key                 = each.value.tag_key
    value               = each.value.tag_value
    propagate_at_launch = true
  }
}
