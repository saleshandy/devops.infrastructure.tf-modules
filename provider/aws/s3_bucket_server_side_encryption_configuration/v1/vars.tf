variable "bucket" {
  type        = string
  description = "Name of the bucket"
}

variable "kms_key_arn" {
  type        = string
  description = "ARN of the KMS key for default SSE-KMS encryption. Null uses SSE-S3 (AES256)"
  default     = null
}

variable "bucket_key_enabled" {
  type        = bool
  description = "Use an S3 Bucket Key with SSE-KMS to reduce KMS requests"
  default     = true
}
