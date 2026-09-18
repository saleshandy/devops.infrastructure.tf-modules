variable "name" {
  type        = string
  description = "Endpoint identifier. Lowercase; DMS rejects uppercase"
}

variable "endpoint_type" {
  type        = string
  description = "source or target"

  validation {
    condition     = contains(["source", "target"], var.endpoint_type)
    error_message = "endpoint_type must be source or target."
  }
}

variable "engine_name" {
  type        = string
  description = "e.g. aurora (MySQL-compatible), aurora-postgresql, mysql, postgres, s3"
}

variable "server_name" {
  type        = string
  description = "Hostname DMS connects to. For Aurora use the cluster writer endpoint, not an instance endpoint, so it follows a failover"
  default     = null
}

variable "port" {
  type    = number
  default = null
}

variable "database_name" {
  type        = string
  description = "Database to connect to. Leave null to let the task's table mappings choose"
  default     = null
}

variable "username" {
  type    = string
  default = null
}

variable "password" {
  type      = string
  default   = null
  sensitive = true
}

variable "ssl_mode" {
  type        = string
  description = "none, require, verify-ca or verify-full. require encrypts without needing a CA bundle"
  default     = "none"

  validation {
    condition     = contains(["none", "require", "verify-ca", "verify-full"], var.ssl_mode)
    error_message = "ssl_mode must be none, require, verify-ca or verify-full."
  }
}

variable "extra_connection_attributes" {
  type        = string
  description = "Engine-specific settings, e.g. initstmt=SET FOREIGN_KEY_CHECKS=0 on a MySQL target"
  default     = null
}

variable "kms_key_arn" {
  type        = string
  description = "Key encrypting the stored connection details. Null uses the AWS managed DMS key"
  default     = null
}

variable "tags" {
  type    = map(string)
  default = { Author : "Terraform" }
}
