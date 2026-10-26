variable "ami" {
  default = null
}

variable "instance_type" {
  default = "t3.micro"
  type    = string
}

variable "subnet_id" {
  default = null
}

variable "security_groups" {
  type    = list(any)
  default = []
}

variable "key_name" {
  default = null
}

variable "associate_public_ip_address" {
  type    = bool
  default = false
}

variable "associate_elastic_ip" {
  default = false
  type    = bool
}

variable "iam_instance_profile" {
  default = null
}

variable "root_block_volume_type" {
  default = "gp3"
}

variable "root_block_volume_size" {
  default = 30
}

# gp3 baseline defaults (3000 IOPS / 125 MB/s). Override for higher-IO workloads.
# iops applies to gp3/io1/io2; throughput applies to gp3 only. Leave at defaults
# (or set to null) for gp2/standard volume types.
variable "root_block_volume_iops" {
  type    = number
  default = 3000
}

variable "root_block_volume_throughput" {
  type    = number
  default = 125
}

variable "root_block_volume_kms_key_id" {
  description = "ARN of a customer-managed KMS key for the root volume (the ARN, not the key id or alias). Null leaves encryption to the account's EBS default"
  type        = string
  default     = null
}

# Defaults: IMDSv2 only, with a hop limit of 1 so containers on the host cannot reach the instance role
variable "metadata_http_endpoint" {
  description = "Instance metadata service: enabled or disabled"
  type        = string
  default     = "enabled"
}

variable "metadata_http_tokens" {
  description = "required allows IMDSv2 only; optional also allows IMDSv1"
  type        = string
  default     = "required"
}

variable "metadata_http_put_response_hop_limit" {
  description = "Network hops an IMDSv2 token response may cross (1-64). 1 keeps it on the host, out of reach of bridge-networked containers"
  type        = number
  default     = 1
}

variable "metadata_instance_metadata_tags" {
  description = "Expose the instance tags through the metadata service: enabled or disabled"
  type        = string
  default     = "disabled"
}

variable "user_data" {
  description = "User data to provide when launching the instance. Do not pass gzip-compressed data via this argument"
  type        = string
  default     = null
}

variable "user_data_base64" {
  description = "Can be used instead of user_data to pass base64-encoded binary data directly"
  type        = string
  default     = null
}

variable "user_data_replace_on_change" {
  description = "When used in combination with user_data or user_data_base64 will trigger a destroy and recreate when set to true"
  type        = bool
  default     = false
}

variable "tags" {
  type = map(any)
  default = {
    Author : "Terraform"
  }
}
