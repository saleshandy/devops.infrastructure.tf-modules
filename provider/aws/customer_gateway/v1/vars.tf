variable "tags" {
    type = map(any)
    default = {
        Author : "Terraform"
    }
}

variable "ip_address" {
    type = string
    default = null
}

variable "bgp_asn" {
    type = number
    default = 65000
}

variable "type" {
    type = string
    default = "ipsec.1"
}