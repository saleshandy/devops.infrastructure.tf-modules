variable "vpc_peering_connection_id" {
  type        = string
  description = "ID of the peering connection requested from the other account or region"
}

variable "tags" {
  type = map(string)
  default = {
    Author : "Terraform"
  }
}
