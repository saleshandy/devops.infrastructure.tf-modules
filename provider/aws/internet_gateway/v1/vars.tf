variable "vpc_id" {}

variable "tags" {
    type = map(any)
    default = {
        Author : "Terraform"
    }
}