variable "name" {
  type = string
}

variable "block_device_mappings" {
  default = []
  type = list(object({
    device_name = string
    ebs = object({
      volume_size           = number
      volume_type           = optional(string, "gp3") 
      delete_on_termination = optional(bool, true)
      encrypted             = optional(bool, true)
    })
  }))
}

variable "capacity_reservation_preference" {
  type    = string
  default = null
}

variable "cpu_core_count" {
  type    = number
  default = null
}

variable "cpu_threads_per_core" {
  type    = number
  default = null
}

variable "cpu_credits" {
  type    = string
  default = null
}

variable "disable_api_stop" {
  type    = bool
  default = false
}

variable "disable_api_termination" {
  type    = bool
  default = false
}

variable "ebs_optimized" {
  type    = bool
  default = false
}

variable "iam_instance_profile_name" {
  type    = string
  default = null
}

variable "image_id" {
  type = string
  default = null
}

variable "shutdown_behavior" {
  type    = string
  default = "null"
}

variable "instance_type" {
  type    = string
  default = null
}

variable "kernel_id" {
  type    = string
  default = null
}

variable "key_name" {
  type    = string
  default = null
}

variable "license_configuration_arn" {
  type    = string
  default = null
}

variable "metadata_http_endpoint" {
  type    = string
  default = "enabled"
}

variable "metadata_http_tokens" {
  type    = string
  default = "required"
}

variable "metadata_hop_limit" {
  type    = number
  default = 1
}

variable "metadata_tags" {
  type    = string
  default = "enabled"
}

variable "metadata_http_protocol_ipv6" {
  type    = string
  default = "disabled"
}

variable "enable_metadata_options" {
  type    = bool
  default = true
}

variable "monitoring_enabled" {
  type    = bool
  default = false
}

variable "associate_public_ip" {
  type    = bool
  default = false
}

variable "availability_zone" {
  type    = string
  default = null
}

variable "ram_disk_id" {
  type    = string
  default = null
}

variable "security_group_ids" {
  type    = list(string)
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "market_type" {
  type    = string
  default = null
}

variable "user_data" {
  type    = string
  default = ""
}