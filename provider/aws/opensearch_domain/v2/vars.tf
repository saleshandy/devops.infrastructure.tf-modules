variable "domain_name" {
  description = "Name of the OpenSearch domain"
  type        = string
}

variable "engine_version" {
  description = "OpenSearch engine version"
  type        = string
  default     = "OpenSearch_2.11"
}

variable "instance_type" {
  description = "Instance type for OpenSearch cluster nodes"
  type        = string
  default     = "t3.small.search"
}

variable "instance_count" {
  description = "Number of instances in the cluster"
  type        = number
  default     = 1
}

variable "dedicated_master_enabled" {
  description = "Whether dedicated master nodes are enabled"
  type        = bool
  default     = false
}

variable "dedicated_master_type" {
  description = "Instance type for dedicated master nodes"
  type        = string
  default     = null
}

variable "dedicated_master_count" {
  description = "Number of dedicated master nodes"
  type        = number
  default     = null
}

variable "zone_awareness_enabled" {
  description = "Whether zone awareness is enabled"
  type        = bool
  default     = false
}

variable "availability_zone_count" {
  description = "Number of availability zones for zone awareness"
  type        = number
  default     = 2
}

# Warm storage options
variable "warm_enabled" {
  description = "Whether to enable warm storage"
  type        = bool
  default     = false
}

variable "warm_count" {
  description = "Number of warm nodes"
  type        = number
  default     = null
}

variable "warm_type" {
  description = "Instance type for warm nodes"
  type        = string
  default     = null
}

# Cold storage options
variable "cold_storage_enabled" {
  description = "Whether to enable cold storage"
  type        = bool
  default     = false
}

# Coordinator node options
variable "coordinator_node_enabled" {
  description = "Whether to enable dedicated coordinator nodes"
  type        = bool
  default     = false
}

variable "coordinator_node_type" {
  description = "Instance type for coordinator nodes (e.g. c6g.large.search)"
  type        = string
  default     = null
}

variable "coordinator_node_count" {
  description = "Number of coordinator nodes"
  type        = number
  default     = null
}

variable "ebs_enabled" {
  description = "Whether EBS volumes are attached to data nodes"
  type        = bool
  default     = true
}

variable "volume_type" {
  description = "Type of EBS volumes (gp2, gp3, io1)"
  type        = string
  default     = "gp3"
}

variable "volume_size" {
  description = "Size of EBS volumes in GB"
  type        = number
  default     = 10
}

variable "iops" {
  description = "Baseline IOPS for EBS volumes (only for gp3 and io1)"
  type        = number
  default     = null
}

variable "throughput" {
  description = "Throughput for EBS volumes in MiB/s (only for gp3)"
  type        = number
  default     = null
}

variable "subnet_ids" {
  description = "List of subnet IDs for VPC endpoint"
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "List of security group IDs for VPC endpoint"
  type        = list(string)
  default     = []
}

variable "encrypt_at_rest_enabled" {
  description = "Whether to enable encryption at rest"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "KMS key ID for encryption at rest"
  type        = string
  default     = null
}

variable "node_to_node_encryption_enabled" {
  description = "Whether to enable node-to-node encryption"
  type        = bool
  default     = true
}

variable "enforce_https" {
  description = "Whether to require HTTPS for all traffic to the domain"
  type        = bool
  default     = true
}

variable "tls_security_policy" {
  description = "TLS security policy"
  type        = string
  default     = "Policy-Min-TLS-1-2-2019-07"
}

variable "custom_endpoint_enabled" {
  description = "Whether to enable a custom endpoint for the OpenSearch domain"
  type        = bool
  default     = false
}

variable "custom_endpoint" {
  description = "Custom endpoint to use for the domain (e.g. search.example.com). Only used when custom_endpoint_enabled = true"
  type        = string
  default     = null
}

variable "custom_endpoint_certificate_arn" {
  description = "ARN of the ACM certificate to use for the custom endpoint. Only used when custom_endpoint_enabled = true"
  type        = string
  default     = null
}

variable "advanced_security_options_enabled" {
  description = "Whether to enable advanced security options"
  type        = bool
  default     = false
}

variable "internal_user_database_enabled" {
  description = "Whether to enable internal user database"
  type        = bool
  default     = false
}

variable "master_user_name" {
  description = "Master user name for advanced security"
  type        = string
  default     = null
}

variable "master_user_password" {
  description = "Master user password for advanced security"
  type        = string
  sensitive   = true
  default     = null
}

variable "access_policies" {
  description = "IAM policy document for access control"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(any)
  default = {
    Author : "Terraform"
  }
}
