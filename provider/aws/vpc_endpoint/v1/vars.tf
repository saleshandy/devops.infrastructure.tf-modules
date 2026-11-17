variable "vpc_id" {
  type        = string
  description = "VPC the endpoint belongs to"
}

variable "service_name" {
  type        = string
  description = "Endpoint service, e.g. com.amazonaws.us-west-2.s3"
}

variable "vpc_endpoint_type" {
  type        = string
  description = "Gateway (S3/DynamoDB, route-table based, free) or Interface (ENI based, billed)"
  default     = "Gateway"

  validation {
    condition     = contains(["Gateway", "Interface"], var.vpc_endpoint_type)
    error_message = "vpc_endpoint_type must be Gateway or Interface."
  }
}

variable "route_table_ids" {
  type        = list(string)
  description = "Gateway only: route tables that get the service prefix-list route"
  default     = []
}

variable "subnet_ids" {
  type        = list(string)
  description = "Interface only: one subnet per AZ for the endpoint ENIs"
  default     = []
}

variable "security_group_ids" {
  type        = list(string)
  description = "Interface only: security groups on the endpoint ENIs (must allow 443 from the clients)"
  default     = []
}

variable "private_dns_enabled" {
  type        = bool
  description = "Interface only: resolve the service's public hostname to the endpoint ENIs"
  default     = true
}

variable "policy" {
  type        = string
  description = "Endpoint policy JSON. null keeps the AWS default (full access)"
  default     = null
}

variable "tags" {
  type = map(any)
  default = {
    Author : "Terraform"
  }
}
