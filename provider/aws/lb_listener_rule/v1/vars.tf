variable "listener_arn" {
    default = null
    type = string
}

variable "priority" {
  default = null
  type = number
}

variable "action_type" {
  type = string
  default = ""
}

variable "action_target_group_arn" {
  default = null
}

variable "condition_host_header" {
  default = null
  type = list
}

variable "condition_path_pattern" {
  default = null
  type = list
}

variable "tags" {
    type = map(any)
    default = {
        Author : "Terraform"
    }
}