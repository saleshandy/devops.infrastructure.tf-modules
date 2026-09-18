variable "domain_name" {
  type        = string
  description = "Primary domain, e.g. *.example.com"
}

variable "subject_alternative_names" {
  type        = list(string)
  description = "Extra names on the certificate. A wildcard does not cover the apex, so add it here if needed"
  default     = []
}

variable "validation_method" {
  type        = string
  description = "DNS or EMAIL"
  default     = "DNS"
}

variable "key_algorithm" {
  type        = string
  description = "RSA_2048, EC_prime256v1, ... Null uses the ACM default (RSA_2048)"
  default     = null
}

variable "tags" {
  type = map(string)
  default = {
    Author : "Terraform"
  }
}
