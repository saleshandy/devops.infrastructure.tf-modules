variable "name" {
    default = ""
    type = string
}

variable "vpc" {
    default = ""
}

variable "tags" {
    type = map(any)
    default = {
        Author : "Terraform"
    }
}