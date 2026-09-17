# Launch template owned by this module. EKS does not propagate node group tags, so
# var.tags are applied at launch to every instance, root volume and primary ENI.
resource "aws_launch_template" "main" {
  name                   = var.node_group_name
  update_default_version = true
  key_name               = var.ec2_ssh_key

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = var.disk_size
      volume_type           = "gp3"
      encrypted             = true
      delete_on_termination = true
    }
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = var.metadata_http_tokens
    http_put_response_hop_limit = var.metadata_hop_limit
  }

  dynamic "tag_specifications" {
    for_each = length(var.tags) > 0 ? ["instance", "volume", "network-interface"] : []

    content {
      resource_type = tag_specifications.value
      tags          = var.tags
    }
  }

  tags = var.tags
}

resource "aws_eks_node_group" "main" {
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids

  ami_type        = var.ami_type
  release_version = var.ami_release_version
  instance_types  = var.instance_types
  capacity_type   = var.capacity_type

  labels = var.labels

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  update_config {
    max_unavailable_percentage = var.max_unavailable_percentage
  }

  # A new launch template version (e.g. tag or disk change) rolls the node group
  launch_template {
    id      = aws_launch_template.main.id
    version = aws_launch_template.main.latest_version
  }

  dynamic "taint" {
    for_each = var.taints

    content {
      key    = taint.value.key
      value  = try(taint.value.value, null)
      effect = taint.value.effect
    }
  }

  tags = var.tags

  lifecycle {
    # Allow external scaling (cluster-autoscaler / console) without plan drift
    ignore_changes = [scaling_config[0].desired_size]
  }
}


# Add-on addition in EKS cluster
resource "aws_eks_addon" "vpc_cni" {
  count = var.addon_create_vpc_cni ? 1 : 0

  cluster_name                = var.cluster_name
  addon_name                  = "vpc-cni"
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"
  addon_version               = var.addon_vpc_cni_version
}

resource "aws_eks_addon" "kube_proxy" {
  count = var.addon_create_kube_proxy ? 1 : 0

  cluster_name                = var.cluster_name
  addon_name                  = "kube-proxy"
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"
  addon_version               = var.addon_kube_proxy_version
}

resource "aws_eks_addon" "coredns" {
  count = var.addon_create_coredns ? 1 : 0

  depends_on = [aws_eks_node_group.main]

  cluster_name                = var.cluster_name
  addon_name                  = "coredns"
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"
  addon_version               = var.addon_coredns_version
}

resource "aws_eks_addon" "ebs_csi_driver" {
  count = var.addon_create_ebs_csi_driver ? 1 : 0

  depends_on = [aws_eks_node_group.main]

  cluster_name                = var.cluster_name
  addon_name                  = "aws-ebs-csi-driver"
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"
  addon_version               = var.addon_ebs_csi_driver_version
}

resource "aws_eks_addon" "aws_guardduty_agent" {
  count = var.addon_create_aws_guardduty_agent ? 1 : 0

  depends_on = [aws_eks_node_group.main]

  cluster_name                = var.cluster_name
  addon_name                  = "aws-guardduty-agent"
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"
  addon_version               = var.addon_aws_guardduty_agent_version
}
