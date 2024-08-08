variable "subnet_ids" {
  description = "availability_zone for RDS instance"
  # default     = ""
  type = list(any)
}

variable "tags" {
  default = {
    Author : "Terraform"
  }
}

variable "name" {
  type = string
}