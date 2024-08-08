variable "name" {
  description = "name for RDS paramter group"
  # default     = ""
  type = string
}
variable "family" {
  description = "family for RDS paramter group"
  # default     = ""
  type = string
}
variable "description" {
  description = "descrition for RDS paramter group"
  # default     = ""
  type = string
}

variable "parameters" {
  default = []
  type    = list(any)
}

variable "tags" {
  type = map(any)
  default = {
    Author : "Terraform"
  }
}
