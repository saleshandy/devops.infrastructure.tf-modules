variable "enabled" {
  type        = bool
  description = "Encrypt every new EBS volume in this account and region by default"
  default     = true
}

variable "kms_key_arn" {
  type        = string
  description = "ARN of the customer-managed KMS key to use as the default EBS key. Required unless use_aws_managed_key is true"
  default     = null
}

variable "use_aws_managed_key" {
  type        = bool
  description = "Keep the AWS-managed aws/ebs key as the default EBS key instead of a customer-managed key"
  default     = false
}
