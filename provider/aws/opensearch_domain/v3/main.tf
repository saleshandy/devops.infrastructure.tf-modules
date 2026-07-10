resource "aws_opensearch_domain" "main" {
  domain_name    = var.domain_name
  engine_version = var.engine_version

  cluster_config {
    instance_type            = var.instance_type
    instance_count           = var.instance_count
    dedicated_master_enabled = var.dedicated_master_enabled
    dedicated_master_type    = var.dedicated_master_type
    dedicated_master_count   = var.dedicated_master_count
    zone_awareness_enabled   = var.zone_awareness_enabled

    # Warm storage support
    warm_enabled = var.warm_enabled
    warm_count   = var.warm_count
    warm_type    = var.warm_type

    dynamic "zone_awareness_config" {
      for_each = var.zone_awareness_enabled ? [1] : []
      content {
        availability_zone_count = var.availability_zone_count
      }
    }

    dynamic "cold_storage_options" {
      for_each = var.cold_storage_enabled ? [1] : []
      content {
        enabled = true
      }
    }

    dynamic "node_options" {
      for_each = var.coordinator_node_enabled ? [1] : []
      content {
        node_type = "coordinator"
        node_config {
          enabled = true
          type    = var.coordinator_node_type
          count   = var.coordinator_node_count
        }
      }
    }
  }

  ebs_options {
    ebs_enabled = var.ebs_enabled
    volume_type = var.volume_type
    volume_size = var.volume_size
    iops        = var.iops
    throughput  = var.throughput
  }

  dynamic "vpc_options" {
    for_each = length(var.subnet_ids) > 0 ? [1] : []
    content {
      subnet_ids         = var.subnet_ids
      security_group_ids = var.security_group_ids
    }
  }

  encrypt_at_rest {
    enabled    = var.encrypt_at_rest_enabled
    kms_key_id = var.kms_key_id
  }

  node_to_node_encryption {
    enabled = var.node_to_node_encryption_enabled
  }

  dynamic "domain_endpoint_options" {
    # Only create the domain_endpoint_options block when a custom
    # endpoint is enabled. When disabled the block will be omitted.
    for_each = var.custom_endpoint_enabled ? [1] : []
    content {
      enforce_https       = var.enforce_https
      tls_security_policy = var.tls_security_policy

      # When present, enable the custom endpoint and provide the values
      # passed in by the module consumer.
      custom_endpoint_enabled         = true
      custom_endpoint                 = var.custom_endpoint
      custom_endpoint_certificate_arn = var.custom_endpoint_certificate_arn
    }
  }

  advanced_security_options {
    enabled                        = var.advanced_security_options_enabled
    internal_user_database_enabled = var.internal_user_database_enabled
    master_user_options {
      master_user_name     = var.master_user_name
      master_user_password = var.master_user_password
    }
  }

  access_policies = var.access_policies

  tags = var.tags

  lifecycle {
    # The master user password is managed out-of-band (set once at creation /
    # rotated directly in OpenSearch). AWS never returns it, so tracking it in
    # Terraform forces the consumer to supply the value on every plan/apply.
    # Ignoring it lets callers leave master_user_password unset (null).
    ignore_changes = [
      advanced_security_options[0].master_user_options[0].master_user_password,
    ]
  }
}
