variable "name" {
    default = null
}

variable "role" {
  default = ""
}

variable "tags" {
    type = map(any)
    default = {
        Author : "Terraform"
    }
}