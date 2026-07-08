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

