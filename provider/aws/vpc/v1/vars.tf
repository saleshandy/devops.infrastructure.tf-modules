variable "cidr_block" {
    default = "10.0.0.0/16"
}

variable "enable_dns_hostnames" {
  default = true
  type = bool
}

variable "tags" {
    type = map(any)
    default = {
        Author : "Terraform"
    }
}