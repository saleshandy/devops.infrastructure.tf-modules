variable "allocation_id" {}

variable "secondary_allocation_ids" {
  type    = list(any)
  default = null
}

variable "subnet_id" {}

variable "tags" {
  type = map(any)
  default = {
    Author : "Terraform"
  }
}