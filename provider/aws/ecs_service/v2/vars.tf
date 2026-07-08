variable "name" {
  default = ""
  type    = string
}

variable "launch_type" {
  type    = string
  default = null
}

variable "cluster" {
  type    = string
  default = ""
}

variable "task_definition" {
  default = ""
  type    = string
}

variable "desired_count" {
  type    = number
  default = 1
}

variable "enable_ecs_managed_tags" {
  type    = bool
  default = true
}

variable "enableLoadBalancer" {
  type    = bool
  default = false
}

variable "target_group_arn" {
  type    = string
  default = ""
}

variable "container_name" {
  type    = string
  default = ""
}

variable "container_port" {
  type    = number
  default = 3000
}

variable "subnets" {
  type    = list(any)
  default = []
}

variable "security_groups" {
  type    = list(any)
  default = []
}

variable "assign_public_ip" {
  type    = bool
  default = false
}

variable "registry_arn" {
  type    = string
  default = ""
}

variable "enable_fargate_spot" {
  type    = bool
  default = false
}

variable "fargate_spot_weight" {
  type    = number
  default = null
}

variable "fargate_weight" {
  type    = number
  default = null
}

variable "fargate_base" {
  type    = number
  default = null
}

variable "propagate_tags" {
  type = string
  default = "TASK_DEFINITION"
}

variable "tags" {
  type = map(any)
  default = {
    Author : "Terraform"
  }
}
