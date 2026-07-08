variable "name" {
    default = ""
    type = string
}

variable "launch_type" {
  type = string
  default = "FARGATE"
}

variable "cluster" {
  type = string
  default = ""
}

variable "task_definition" {
  default = ""
  type = string
}

variable "desired_count" {
  type = number
  default = 1
}

variable "enable_ecs_managed_tags" {
  type = bool
  default = true
}

variable "enableLoadBalancer" {
  type = bool
  default = false
}

variable "target_group_arn" {
  type = string
  default = ""
}

variable "container_name" {
  type = string
  default = ""
}

variable "container_port" {
  type = number
  default = 3000
}

variable "subnets" {
  type = list
  default = []
}

variable "security_groups" {
  type = list
  default = []
}

variable "assign_public_ip" {
  type = bool
  default = false
}

variable "registry_arn" {
  type = string
  default = ""
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