variable "zone_id" {
  type        = string
  description = "Private hosted zone in this account that the other account's VPC may associate with"
}

variable "vpc_id" {
  type        = string
  description = "VPC in the other account being authorized"
}

variable "vpc_region" {
  type        = string
  description = "Region of that VPC. Defaults to the provider's region"
  default     = null
}
