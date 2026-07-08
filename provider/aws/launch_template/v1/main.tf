resource "aws_launch_template" "this" {
  name          = var.name
  image_id      = var.image_id
  instance_type = var.instance_type

  disable_api_stop        = var.disable_api_stop
  disable_api_termination = var.disable_api_termination
  ebs_optimized           = var.ebs_optimized
  instance_initiated_shutdown_behavior = var.shutdown_behavior
  kernel_id     = var.kernel_id
  key_name      = var.key_name
  ram_disk_id   = var.ram_disk_id
  vpc_security_group_ids = var.security_group_ids
  user_data     = var.user_data != "" ? filebase64(var.user_data) : null

  dynamic "block_device_mappings" {
    for_each = var.block_device_mappings
    content {
      device_name = block_device_mappings.value.device_name

      ebs {
        volume_size           = block_device_mappings.value.ebs.volume_size
        volume_type           = try(block_device_mappings.value.ebs.volume_type, "gp3")
        delete_on_termination = try(block_device_mappings.value.ebs.delete_on_termination, true)
        encrypted             = try(block_device_mappings.value.ebs.encrypted, true)
      }
    }
  }

  dynamic "cpu_options" {
    for_each = var.cpu_core_count != null ? [1] : []
    content {
      core_count       = var.cpu_core_count
      threads_per_core = var.cpu_threads_per_core
    }
  }

  dynamic "credit_specification" {
    for_each = var.cpu_credits != null ? [1] : []
    content {
      cpu_credits = var.cpu_credits
    }
  }

  dynamic "capacity_reservation_specification" {
    for_each = var.capacity_reservation_preference != null ? [1] : []
    content {
      capacity_reservation_preference = var.capacity_reservation_preference
    }
  }

  dynamic "iam_instance_profile" {
    for_each = var.iam_instance_profile_name != null ? [1] : []
    content {
      name = var.iam_instance_profile_name
    }
  }

  dynamic "instance_market_options" {
    for_each = var.market_type != null ? [1] : []
    content {
      market_type = var.market_type
    }
  }

  dynamic "license_specification" {
    for_each = var.license_configuration_arn != null ? [1] : []
    content {
      license_configuration_arn = var.license_configuration_arn
    }
  }

  dynamic "metadata_options" {
    for_each = var.enable_metadata_options ? [1] : []
    content {
      http_endpoint               = var.metadata_http_endpoint
      http_tokens                 = var.metadata_http_tokens
      http_put_response_hop_limit = var.metadata_hop_limit
      http_protocol_ipv6          = var.metadata_http_protocol_ipv6
      instance_metadata_tags      = var.metadata_tags
    }
  }

  dynamic "monitoring" {
    for_each = var.monitoring_enabled ? [1] : []
    content {
      enabled = true
    }
  }

  dynamic "network_interfaces" {
    for_each = var.associate_public_ip ? [1] : []
    content {
      associate_public_ip_address = true
    }
  }

  dynamic "placement" {
    for_each = var.availability_zone != null ? [1] : []
    content {
      availability_zone = var.availability_zone
    }
  }

  dynamic "tag_specifications" {
    for_each = length(var.tags) > 0 ? [1] : []
    content {
      resource_type = "instance"
      tags          = var.tags
    }
  }
}
