variable "zone_id" {
  type        = string
  description = "Private hosted zone to associate with. May live in another account"
}

variable "vpc_id" {
  type        = string
  description = "VPC in this account that should resolve the zone's records"
}

variable "vpc_region" {
  type        = string
  description = "Region of the VPC. Defaults to the provider's region"
  default     = null
}
