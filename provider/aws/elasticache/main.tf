# Module      : Elasticache Replication Group
# Description : Terraform module which creates standalone instance for Elasticache Redis.
resource "aws_elasticache_replication_group" "default" {
  count                      = "${var.replication_enabled}" ? 1 : 0
  engine                     = var.engine
  replication_group_id       = var.replication_group_id
  description                = var.description
  engine_version             = var.engine_version
  port                       = var.port
  parameter_group_name       = var.parameter_group_name
  node_type                  = var.node_type
  automatic_failover_enabled = var.automatic_failover_enabled
  subnet_group_name          = var.subnet_group_name
  security_group_ids         = var.security_group_ids
  security_group_names       = var.security_group_names
  snapshot_arns              = var.snapshot_arns
  snapshot_name              = var.snapshot_name
  notification_topic_arn     = var.notification_topic_arn
  snapshot_window            = var.snapshot_window
  snapshot_retention_limit   = var.snapshot_retention_limit
  apply_immediately          = var.apply_immediately
  availability_zones         = slice("${var.availability_zones}", 0, "${var.num_cache_clusters}")
  num_cache_clusters      = var.num_cache_clusters
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  maintenance_window         = var.maintenance_window
  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  transit_encryption_enabled = var.transit_encryption_enabled
  auth_token                 = var.auth_token
  kms_key_id                 = var.kms_key_id
  tags                       = var.tags
}

# Module      : Elasticache Replication Group
# Description : Terraform module which creates cluster for Elasticache Redis.
# TODO  Cluster module not stable yet for redis
resource "aws_elasticache_replication_group" "cluster" {
  count                      = "${var.cluster_replication_enabled}" ? 1 : 0
  engine                     = var.engine
  replication_group_id       = var.replication_group_id
  description                = var.description
  engine_version             = var.engine_version
  port                       = var.port
  parameter_group_name       = var.parameter_group_name
  node_type                  = var.node_type
  automatic_failover_enabled = var.automatic_failover_enabled
  subnet_group_name          = var.subnet_group_name
  security_group_ids         = var.security_group_ids
  security_group_names       = var.security_group_names
  snapshot_arns              = var.snapshot_arns
  snapshot_name              = var.snapshot_name
  notification_topic_arn     = var.notification_topic_arn
  snapshot_window            = var.snapshot_window
  snapshot_retention_limit   = var.snapshot_retention_limit
  apply_immediately          = var.apply_immediately
  #   availability_zones            = slice("${var.availability_zones}", 0, "${var.num_node_groups}")
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  maintenance_window         = var.maintenance_window
  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  transit_encryption_enabled = var.transit_encryption_enabled
  auth_token                 = var.auth_token
  kms_key_id                 = var.kms_key_id
  tags                       = var.tags
  cluster_mode {
    replicas_per_node_group = var.replicas_per_node_group #Replicas per Shard
    num_node_groups         = var.num_node_groups         #Number of Shards
  }
}

# Module      : Elasticache Cluster
# Description : Terraform module which creates cluster for Elasticache Memcached.
# TODO Memcache module not tested yet
resource "aws_elasticache_cluster" "default" {
  count                        = "${var.cluster_enabled}" ? 1 : 0
  engine                       = var.engine
  cluster_id                   = var.cluster_id
  engine_version               = var.engine_version
  port                         = var.port
  num_cache_nodes              = var.num_cache_nodes
  az_mode                      = var.az_mode
  parameter_group_name         = var.parameter_group_name
  node_type                    = var.node_type
  subnet_group_name            = var.subnet_group_name
  security_group_ids           = var.security_group_ids
  security_group_names         = var.security_group_names
  snapshot_arns                = var.snapshot_arns
  snapshot_name                = var.snapshot_name
  notification_topic_arn       = var.notification_topic_arn
  snapshot_window              = var.snapshot_window
  snapshot_retention_limit     = var.snapshot_retention_limit
  apply_immediately            = var.apply_immediately
  preferred_availability_zones = slice("${var.availability_zones}", 0, "${var.num_cache_nodes}")
  maintenance_window           = var.maintenance_window
  tags                         = var.tags
}
