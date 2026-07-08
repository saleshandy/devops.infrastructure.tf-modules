variable "allocation_id" {}

variable "subnet_id" {}

variable "tags" {
  type = map(any)
  default = {
    Author : "Terraform"
  }
}