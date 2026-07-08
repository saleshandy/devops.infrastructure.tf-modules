module "launch_template" {
  count  = var.create_launch_template ? 1 : 0
  source = "github.com/opsonspot/terraform-modules//provider/aws/launch_template/v1"
  name   = var.node_group_name
  shutdown_behavior = null
  metadata_http_endpoint      = "enabled"
  metadata_http_tokens        = "optional"
  metadata_hop_limit          = 3
  metadata_http_protocol_ipv6 = "enabled"
  metadata_tags               = "enabled"

  block_device_mappings = [
    {
      device_name = "/dev/xvda"
      ebs = {
        volume_size           = var.disk_size
        volume_type           = "gp3"
        delete_on_termination = true
        encrypted             = true
      }
    }
  ]
}

locals {
  # Use created launch template if available, otherwise use provided variables
  use_launch_template = var.create_launch_template || (var.launch_template_id != null && var.launch_template_id != "")
  final_launch_template_id = var.create_launch_template ? module.launch_template[0].launch_template_id : var.launch_template_id
  final_launch_template_version = var.create_launch_template ? "$Latest" : var.launch_template_version
}

resource "aws_eks_node_group" "main" {
  cluster_name = var.cluster_name

  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn

  subnet_ids = var.subnet_ids

  ami_type       = var.ami_type
  disk_size = local.use_launch_template ? null : var.disk_size
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

  dynamic "launch_template" {
    for_each = local.use_launch_template ? [1] : []
    content {
      id      = local.final_launch_template_id
      version = local.final_launch_template_version
    }
  }

  # Optional: Allow external changes without Terraform plan difference
  lifecycle {
    ignore_changes = [scaling_config[0].desired_size, launch_template[0].version]
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

data "aws_region" "current" {}

resource "null_resource" "asg_tags" {
  depends_on = [aws_eks_node_group.main]

  triggers = {
    node_group_name = var.node_group_name
    tags_hash       = jsonencode(var.tags)
  }

  provisioner "local-exec" {
    command = <<-EOT
      AWS_REGION="${data.aws_region.current.name}"

      if [ -z "$AWS_REGION" ]; then
        AWS_REGION="${data.aws_region.current.name}"
      fi
      
      # Get all ASGs with the node group name in them
      ASG_NAMES=$(aws autoscaling describe-auto-scaling-groups --region $AWS_REGION --query "AutoScalingGroups[?contains(Tags[?Key=='eks:nodegroup-name'].Value, '${var.node_group_name}')].AutoScalingGroupName" --output text)
      
      for ASG_NAME in $ASG_NAMES; do
        echo "Tagging ASG: $ASG_NAME"
        ${join("\n        ", [for key, value in var.tags : "aws autoscaling create-or-update-tags --region $AWS_REGION --tags ResourceId=$ASG_NAME,ResourceType=auto-scaling-group,Key='${key}',Value='${value}',PropagateAtLaunch=true"])}
      done
    EOT
  }
}