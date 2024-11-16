variable "family" {
  type    = string
  default = ""
}

variable "requires_compatibilities" {
  type    = list(any)
  default = ["FARGATE"]
}

variable "network_mode" {
  type    = string
  default = "awsvpc"
}

variable "cpu" {
  default = 1024
}

variable "memory" {
  default = 2048
}

variable "execution_role_arn" {
  default = null
  type    = string
}

variable "task_role_arn" {
  default = null
  type    = string
}

variable "container_name" {
  type    = string
  default = ""
}

variable "container_image" {
  type    = string
  default = ""
}

variable "container_essential" {
  type    = bool
  default = true
}

variable "container_containerPort" {
  type    = number
  default = 3000
}

variable "container_hostPort" {
  type    = number
  default = 3000

}

variable "ulimits_nofile_softLimit" {
  default = 1024
  type    = number
}

variable "ulimits_nofile_hardLimit" {
  default = 1024
  type    = number
}

variable "logConfiguration" {
  type    = any
  default = null
  validation {
    condition = (
      var.logConfiguration != null ?
      can(keys(var.logConfiguration)) :
      true
    )
    error_message = "logConfiguration must be an object."
  }
}

variable "region" {
  default = "us-west-2"
  type    = string
}

variable "awslogs_stream_prefix" {
  default = ""
}

variable "operating_system_family" {
  type    = string
  default = "LINUX"
}

variable "cpu_architecture" {
  type    = string
  default = "X86_64"
}

variable "tags" {
  type = map(any)
  default = {
    Author : "Terraform"
  }
}

variable "environment_variables" {
  type    = map(string)
  default = null
}
