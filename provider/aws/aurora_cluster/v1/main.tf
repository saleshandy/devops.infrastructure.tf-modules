resource "aws_rds_cluster" "main" {
  cluster_identifier = var.cluster_identifier
  engine             = var.engine
  engine_version     = var.engine_version
  engine_mode        = "provisioned"
  database_name      = var.database_name
  port               = var.port

  # RDS generates the master password and keeps it in Secrets Manager; it never lands in Terraform state
  master_username               = var.master_username
  manage_master_user_password   = true
  master_user_secret_kms_key_id = var.kms_key_arn

  db_subnet_group_name            = var.db_subnet_group_name
  vpc_security_group_ids          = var.vpc_security_group_ids
  db_cluster_parameter_group_name = var.db_cluster_parameter_group_name
  storage_type                    = var.storage_type

  # Encryption and its key are fixed at creation
  storage_encrypted = true
  kms_key_id        = var.kms_key_arn

  backup_retention_period      = var.backup_retention_period
  preferred_backup_window      = var.preferred_backup_window
  preferred_maintenance_window = var.preferred_maintenance_window
  copy_tags_to_snapshot        = true
  skip_final_snapshot          = var.skip_final_snapshot
  final_snapshot_identifier    = var.skip_final_snapshot ? null : "${var.cluster_identifier}-final"
  deletion_protection          = var.deletion_protection

  enabled_cloudwatch_logs_exports     = var.enabled_cloudwatch_logs_exports
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  database_insights_mode              = var.database_insights_mode
  allow_major_version_upgrade         = var.allow_major_version_upgrade
  apply_immediately                   = var.apply_immediately

  tags = var.tags
}

resource "aws_rds_cluster_instance" "main" {
  for_each = var.instances

  identifier         = each.key
  cluster_identifier = aws_rds_cluster.main.id
  engine             = aws_rds_cluster.main.engine
  engine_version     = aws_rds_cluster.main.engine_version
  instance_class     = coalesce(each.value.instance_class, var.instance_class)
  availability_zone  = each.value.availability_zone
  promotion_tier     = each.value.promotion_tier

  db_subnet_group_name    = var.db_subnet_group_name
  db_parameter_group_name = var.db_parameter_group_name
  publicly_accessible     = false
  ca_cert_identifier      = var.ca_cert_identifier

  auto_minor_version_upgrade   = var.auto_minor_version_upgrade
  preferred_maintenance_window = var.preferred_maintenance_window
  apply_immediately            = var.apply_immediately
  copy_tags_to_snapshot        = true

  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_kms_key_id       = var.performance_insights_enabled ? var.kms_key_arn : null
  performance_insights_retention_period = var.performance_insights_enabled ? var.performance_insights_retention_period : null
  monitoring_interval                   = var.monitoring_interval
  monitoring_role_arn                   = var.monitoring_interval > 0 ? var.monitoring_role_arn : null

  tags = var.tags
}
