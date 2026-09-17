*Example*

Aurora MySQL cluster with one writer, encrypted with a customer-managed key

```
module "example_aurora" {
  source             = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/aws/aurora_cluster/v1"
  cluster_identifier = "example-cluster"
  engine             = "aurora-mysql"            # Default: aurora-mysql
  engine_version     = "8.4.mysql_aurora.8.4.8"
  master_username    = "admin"

  db_subnet_group_name            = module.example_subnet_group.rds_subnet_group_id
  vpc_security_group_ids          = [module.example_rds_sg.security_group_id]
  db_cluster_parameter_group_name = module.example_cluster_parameter_group.db_parameter_group_name
  db_parameter_group_name         = module.example_parameter_group.db_parameter_group_name
  kms_key_arn                     = module.example_kms_key.kms_key_arn

  preferred_backup_window         = "07:53-08:23"          # UTC
  preferred_maintenance_window    = "sun:10:30-sun:11:00"  # UTC
  enabled_cloudwatch_logs_exports = ["audit", "error", "slowquery"]

  instance_class = "db.r8g.xlarge"
  instances = {
    "example" = { availability_zone = "us-west-2a" }
    # "example-reader" = { promotion_tier = 2 }  # add a reader later
  }

  tags = {
    Name : "example-cluster",
    Author : "Terraform",
  }
}
```

Notes

- Master password: RDS generates it and stores it in Secrets Manager (encrypted with `kms_key_arn` when set), so it never appears in Terraform state. Read it with `aws secretsmanager get-secret-value --secret-id <master_user_secret_arn>`. RDS rotates it every 7 days by default, so applications should use their own database users rather than the master user.
- Storage is always encrypted. The encryption key can't be changed after creation.
- `instances` is keyed by instance identifier. Add an entry to add a reader; `promotion_tier` (0-15, default 1) sets failover order.
- Create parameter groups with `rds_cluster_parameter_group/v1` and `db_parameter_group/v1`.
- Defaults: deletion protection on, 7-day backups, a final snapshot named `<cluster_identifier>-final` on destroy, Performance Insights on (7 days), auto minor version upgrades off (upgrade by changing `engine_version`).
- Exported logs go to CloudWatch log groups `/aws/rds/cluster/<cluster_identifier>/<type>`, which never expire by default. Set their retention separately.
- Enhanced Monitoring (`monitoring_interval` > 0) needs a role trusted by `monitoring.rds.amazonaws.com` with the `AmazonRDSEnhancedMonitoringRole` policy, passed as `monitoring_role_arn`.
