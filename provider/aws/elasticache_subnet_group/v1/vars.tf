variable "name" {
  type        = string
  description = "Name of the elastic subnet groups"
}

variable "subnet_ids" {
  type        = list
  description = "List of subnet ids to be attached to this subnet group."
}

variable "description" {
  type        = string
  description = "Description of the subnet group"
}

variable "tags" {
    type = map(any)
    default = {
        Author : "Terraform"
    }
}