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

variable "parameters" {
  default = []
  type = list
}

variable "tags" {
    type = map(any)
    default = {
        Author : "Terraform"
    }
}