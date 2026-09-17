variable "cluster_identifier" {
  type        = string
  description = "Name of the Aurora cluster"
}

variable "engine" {
  type        = string
  description = "aurora-mysql or aurora-postgresql"
  default     = "aurora-mysql"
}

variable "engine_version" {
  type        = string
  description = "Exact engine version, e.g. 8.4.mysql_aurora.8.4.8"
}

variable "database_name" {
  type        = string
  description = "Name of a database to create with the cluster. Null creates none"
  default     = null
}

variable "port" {
  type        = number
  description = "Listener port. Null uses the engine default (3306 MySQL, 5432 PostgreSQL)"
  default     = null
}

variable "master_username" {
  type        = string
  description = "Master user name; its password is generated and stored in Secrets Manager by RDS"
}

variable "db_subnet_group_name" {
  type        = string
  description = "DB subnet group for the cluster and its instances"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "Security groups attached to the cluster"
}

variable "db_cluster_parameter_group_name" {
  type        = string
  description = "Cluster parameter group. Null uses the engine default"
  default     = null
}

variable "db_parameter_group_name" {
  type        = string
  description = "DB (instance) parameter group for every instance. Null uses the engine default"
  default     = null
}

variable "kms_key_arn" {
  type        = string
  description = "KMS key for storage, Performance Insights and the master user secret. Null uses the AWS-managed keys"
  default     = null
}

variable "storage_type" {
  type        = string
  description = "Null for Aurora Standard, or aurora-iopt1 for I/O-Optimized"
  default     = null
}

variable "backup_retention_period" {
  type        = number
  description = "Days to keep automated backups (1-35)"
  default     = 7
}

variable "preferred_backup_window" {
  type        = string
  description = "Daily backup window in UTC, e.g. 07:53-08:23. Null lets RDS choose"
  default     = null
}

variable "preferred_maintenance_window" {
  type        = string
  description = "Weekly maintenance window in UTC for the cluster and instances, e.g. sun:10:30-sun:11:00. Null lets RDS choose"
  default     = null
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Skip the final snapshot on destroy. When false, the snapshot is named <cluster_identifier>-final"
  default     = false
}

variable "deletion_protection" {
  type    = bool
  default = true
}

variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  description = "Logs exported to CloudWatch, e.g. [\"audit\", \"error\", \"slowquery\"]"
  default     = []
}

variable "iam_database_authentication_enabled" {
  type    = bool
  default = false
}

variable "database_insights_mode" {
  type        = string
  description = "standard or advanced"
  default     = "standard"
}

variable "allow_major_version_upgrade" {
  type    = bool
  default = false
}

variable "apply_immediately" {
  type        = bool
  description = "Apply modifications immediately instead of in the next maintenance window"
  default     = false
}

variable "instance_class" {
  type        = string
  description = "Default instance class for entries in instances that don't set their own"
  default     = null
}

variable "instances" {
  type = map(object({
    instance_class    = optional(string)
    availability_zone = optional(string)
    promotion_tier    = optional(number, 1)
  }))
  description = "Cluster instances keyed by instance identifier. The first one created becomes the writer"
}

variable "ca_cert_identifier" {
  type    = string
  default = "rds-ca-rsa2048-g1"
}

variable "auto_minor_version_upgrade" {
  type        = bool
  description = "Off by default: upgrade deliberately by changing engine_version"
  default     = false
}

variable "performance_insights_enabled" {
  type    = bool
  default = true
}

variable "performance_insights_retention_period" {
  type        = number
  description = "Days to keep Performance Insights data (7 is free)"
  default     = 7
}

variable "monitoring_interval" {
  type        = number
  description = "Enhanced Monitoring interval in seconds (0, 1, 5, 10, 15, 30, 60). 0 disables it"
  default     = 0
}

variable "monitoring_role_arn" {
  type        = string
  description = "Role trusted by monitoring.rds.amazonaws.com with AmazonRDSEnhancedMonitoringRole. Required when monitoring_interval > 0"
  default     = null
}

variable "tags" {
  type = map(string)
  default = {
    Author : "Terraform"
  }
}
