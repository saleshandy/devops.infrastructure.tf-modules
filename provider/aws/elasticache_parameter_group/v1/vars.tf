variable "name" {
    default = ""
}

variable "family" {
  default = ""
  type = string
}

variable "description" {
  default = ""
  type = string
}

variable "tags" {
    type = map(any)
    default = {
        Author : "Terraform"
    }
}