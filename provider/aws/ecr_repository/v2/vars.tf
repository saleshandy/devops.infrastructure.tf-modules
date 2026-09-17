variable "name" {
  type        = string
  description = "Name of the repository"
}

variable "image_tag_mutability" {
  type        = string
  description = "MUTABLE or IMMUTABLE"
  default     = "MUTABLE"
}

variable "scan_on_push" {
  type        = bool
  description = "Scan images for vulnerabilities on push"
  default     = true
}

variable "kms_key_arn" {
  type        = string
  description = "ARN of the KMS key to encrypt images with. Null uses AES256. Changing it replaces the repository"
  default     = null
}

variable "force_delete" {
  type        = bool
  description = "Allow deleting or replacing the repository while it still contains images"
  default     = false
}

variable "tags" {
  type = map(string)
  default = {
    Author : "Terraform"
  }
}
