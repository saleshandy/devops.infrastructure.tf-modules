variable "vpc_id" {
  description = "The ID of the VPC to create the VPN Gateway in."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the VPN Gateway."
  type        = map(string)
  default = {
    Name = "main"
  }
}

variable "amazon_side_asn" {
  description = "The ASN for the Amazon side of the VPN gateway."
  type        = number
  default     = null
}
