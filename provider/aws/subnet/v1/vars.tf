variable "cidr_block" {
  default = "10.0.0.0/20"
}

variable "vpc_id" {}

variable "availability_zone" {
  default = ""
}

variable "tags" {
    type = map(any)
    default = {
        Author : "Terraform"
    }
}