variable "name" {
    default = ""
    type = string
}

variable "port" {
  type = number
  default = 80
}

variable "protocol" {
  type = string
  default = "HTTP"
}

variable "target_type" {
  type = string
  default = "instance"
}

variable "vpc_id" {
  type = string
  default = ""
}

variable "tags" {
    type = map(any)
    default = {
        Author : "Terraform"
    }
}

variable "health_check_protocol" {
  default = "HTTP"
  type = string
}

variable "health_check_path" {
  default = "/"
  type = string
}

variable "health_check_port" {
  default = "traffic-port"
}

variable "health_check_healthy_threshold" {
  type = number
  default = 5
}

variable "health_check_unhealthy_threshold" {
  type = number
  default = 2
}

variable "health_check_timeout" {
  type = number
  default = 10
}

variable "health_check_interval" {
  type = number
  default = 30
}

variable "health_check_matcher" {
  default = 200
  type = number
}