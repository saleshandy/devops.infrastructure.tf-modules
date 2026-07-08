variable "load_balancer_arn" {
    default = ""
}

variable "port" {
  default = 80
  type = number
}

variable "protocol" {
  default = ""
}

variable "ssl_policy" {
  default = null
}

variable "certificate_arn" {
  default = null
}

variable "alpn_policy" {
  default = null
}

variable "type" {
  default = "forward"
}

variable "target_group_arn" {
  default = null
}

variable "redirect_port" {
  default = 443
}

variable "redirect_protocol" {
  default = "HTTPS"
}

variable "redirect_status_code" {
  default = "HTTP_301"
}

variable "tags" {
    type = map(any)
    default = {
        Author : "Terraform"
    }
}