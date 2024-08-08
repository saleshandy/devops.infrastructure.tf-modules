variable "route_table_id" {}

variable "destination_cidr_block" {}

variable "is_gateway" {
  default = false
}

variable "gateway_id" {
    default = ""
}

variable "is_nat_gateway" {
  default = false
}

variable "nat_gateway_id" {
    default = ""
}

variable "is_vpc_peering_connection" {
  default = false
}

variable "vpc_peering_connection_id" {
    default = ""
}