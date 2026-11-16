variable "name" {}

variable "description" {}

variable "vpc_id" {}

variable "ingress_rules" {
  type = list(object({
    from            = number
    to              = number
    protocol        = string
    cidr            = list(string)
    security_groups = optional(list(string), [])
    description     = optional(string)
  }))
  default = []
}

variable "egress_rules" {
  type = list(object({
    from        = number
    to          = number
    protocol    = string
    cidr        = list(string)
    description = optional(string)
  }))
  default = []
}

variable "tags" {
  type = map(any)
  default = {
    Author : "Terraform"
  }
}
