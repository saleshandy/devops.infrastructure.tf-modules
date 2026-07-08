variable "name" {}

variable "assume_role_policy" {
  default = ""
}

variable "tags" {
  type = map(any)
  default = {
    Author : "Terraform"
  }
}

