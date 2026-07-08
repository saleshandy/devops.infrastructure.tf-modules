variable "cluster_name" {
  type = string
}

variable "kafka_version" {
  default = "2.8.1"
  type    = string
}

variable "number_of_broker_nodes" {
  default = 3
  type    = number
}

variable "instance_type" {
  type = string
}

variable "client_subnets" {
  type = list(any)
}

variable "volume_size" {
  type    = number
  default = 1000
}

variable "security_groups" {
  type = list(any)
}

variable "configuration_info_arn" {
  type = string
}

variable "configuration_info_revision" {
  type = string
}

variable "tags" {
  type = map(any)
  default = {
    Author : "Terraform"
  }
}
