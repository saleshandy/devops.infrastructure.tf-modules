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
