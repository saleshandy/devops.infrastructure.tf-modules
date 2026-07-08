variable "name" {
  type = string
}

variable "policy" {
    
}

variable "tags" {
    type = map(any)
    default = {
        Author : "Terraform"
    }
}