variable "name" {
    default = ""
    type = string
}

variable "internal" {
  type = bool
  default = false
}

variable "load_balancer_type" {
  type = string
  default = "application"
}

variable "security_groups" {
  type = list
  default = []
}

variable "subnets" {
  type = list
  default =[]
}

variable "enable_deletion_protection" {
  type = bool
  default = true
}

variable "access_logs_bucket" {
  default = null
  type = string
}

variable "idle_timeout" {
  default = 60
  type = number
  
}

variable "tags" {
    type = map(any)
    default = {
        Author : "Terraform"
    }
}