variable "name" {
  description = "The name of the parameter"
  type        = string
}

variable "type" {
  description = "The type of the parameter. Valid types are String, StringList and SecureString"
  type        = string
  default     = "String"
  validation {
    condition     = contains(["String", "StringList", "SecureString"], var.type)
    error_message = "Parameter type must be one of: String, StringList, SecureString."
  }
}

variable "value" {
  description = "The value of the parameter"
  type        = string
}

variable "description" {
  description = "The description of the parameter"
  type        = string
  default     = null
}

variable "tier" {
  description = "The tier of the parameter. Valid tiers are Standard, Advanced, Intelligent-Tiering"
  type        = string
  default     = "Standard"
  validation {
    condition     = contains(["Standard", "Advanced", "Intelligent-Tiering"], var.tier)
    error_message = "Parameter tier must be one of: Standard, Advanced, Intelligent-Tiering."
  }
}

variable "key_id" {
  description = "The KMS key id or arn for encrypting a SecureString"
  type        = string
  default     = null
}

variable "overwrite" {
  description = "Overwrite an existing parameter"
  type        = bool
  default     = false
}

variable "allowed_pattern" {
  description = "A regular expression used to validate the parameter value"
  type        = string
  default     = null
}

variable "data_type" {
  description = "The data type for the parameter. Valid values: text and aws:ec2:image"
  type        = string
  default     = "text"
  validation {
    condition     = contains(["text", "aws:ec2:image"], var.data_type)
    error_message = "Data type must be one of: text, aws:ec2:image."
  }
}

variable "tags" {
  description = "A map of tags to assign to the parameter"
  type        = map(any)
  default = {
    Author : "Terraform"
  }
}
