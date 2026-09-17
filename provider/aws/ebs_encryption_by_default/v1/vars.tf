variable "enabled" {
  type        = bool
  description = "Encrypt every new EBS volume in this account and region by default"
  default     = true
}

variable "kms_key_arn" {
  type        = string
  description = "ARN of the customer-managed KMS key to use as the default EBS key. Null keeps the AWS-managed aws/ebs key"
  default     = null
}
