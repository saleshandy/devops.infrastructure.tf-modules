variable "description" {
  type        = string
  description = "Description of the KMS key"
  default     = null
}

variable "key_usage" {
  type        = string
  description = "ENCRYPT_DECRYPT, SIGN_VERIFY, GENERATE_VERIFY_MAC or KEY_AGREEMENT"
  default     = "ENCRYPT_DECRYPT"
}

variable "customer_master_key_spec" {
  type        = string
  description = "Key spec, e.g. SYMMETRIC_DEFAULT, RSA_2048, HMAC_256"
  default     = "SYMMETRIC_DEFAULT"
}

variable "enable_key_rotation" {
  type        = bool
  description = "Automatic rotation of the key material (symmetric encryption keys only)"
  default     = true
}

variable "rotation_period_in_days" {
  type        = number
  description = "Days between automatic rotations (90-2560). Ignored when rotation is disabled"
  default     = 365
}

variable "deletion_window_in_days" {
  type        = number
  description = "Waiting period (7-30 days) before a scheduled key deletion completes"
  default     = 30
}

variable "multi_region" {
  type    = bool
  default = false
}

variable "policy" {
  type        = string
  description = "Key policy JSON. Null applies the AWS default key policy (account root has full access, IAM policies control use)"
  default     = null
}

variable "alias_name" {
  type        = string
  description = "Alias for the key, with or without the alias/ prefix. Null creates no alias"
  default     = null
}

variable "tags" {
  type = map(string)
  default = {
    Author : "Terraform"
  }
}
