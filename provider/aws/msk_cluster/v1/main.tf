resource "aws_msk_cluster" "main" {
  cluster_name           = var.cluster_name
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.number_of_broker_nodes

  broker_node_group_info {
    instance_type  = var.instance_type
    client_subnets = var.client_subnets

    storage_info {
      ebs_storage_info {
        volume_size = var.volume_size
      }
    }

    security_groups = var.security_groups
  }
  configuration_info {
    arn      = var.configuration_info_arn
    revision = var.configuration_info_revision
  }

  open_monitoring {
    prometheus {
      jmx_exporter {
        enabled_in_broker = true
      }

      node_exporter {
        enabled_in_broker = true
      }
    }
  }

  tags = var.tags
}
