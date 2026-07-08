variable "name" {
    default = ""
}

variable "namespace_id" {
  default = ""
}

variable "routing_policy" {
  default = "MULTIVALUE"
}

variable "dns_records_ttl" {
  default = 10
  type = number
}

variable "dns_records_type" {
  default = "A"
}

variable "tags" {
    type = map(any)
    default = {
        Author : "Terraform"
    }
}