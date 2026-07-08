variable "aws_service_name" {
  description = "The AWS service principal name which will make use of this role. For example: elasticbeanstalk.amazonaws.com"
  type        = string
}

variable "custom_suffix" {
  description = "Additional string appended to the role name. Not all AWS services support custom suffixes"
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the role"
  type        = string
  default     = null
}

variable "tags" {
  description = "Key-value mapping of tags for the IAM role"
  type        = map(any)
  default     = {
    Author : "Terraform"
  }
}