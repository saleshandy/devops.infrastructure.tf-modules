variable "vpc_id" {
  type        = string
  description = "ID of the requester VPC"
}

variable "peer_vpc_id" {
  type        = string
  description = "ID of the accepter VPC"
}

variable "peer_owner_id" {
  type        = string
  description = "AWS account ID that owns the accepter VPC. Null for a VPC in the same account"
  default     = null
}

variable "peer_region" {
  type        = string
  description = "Region of the accepter VPC. Null for the same region; must stay null when auto_accept is true"
  default     = null
}

variable "auto_accept" {
  type        = bool
  description = "Accept the connection immediately. Only possible when both VPCs are in the same account and region"
  default     = false
}

variable "tags" {
  type = map(string)
  default = {
    Author : "Terraform"
  }
}
