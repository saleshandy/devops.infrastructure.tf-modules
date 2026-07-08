variable "name" {
    default = ""
    type = string
}

variable "tags" {
    type = map(any)
    default = {
        Author : "Terraform"
    }
}