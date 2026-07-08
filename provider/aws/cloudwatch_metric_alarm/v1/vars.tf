variable "alarm_name" {
  type = string
}

variable "comparison_operator" {
  type = string

}

variable "evaluation_periods" {
  type    = number
  default = 2
}

variable "metric_name" {
  type = string
}

variable "namespace" {
  type = string
}

variable "period" {
  type    = number
  default = 300
}

variable "statistic" {
  type = string
  default = "Average"
}

variable "threshold" {
  type = number
  default = 90
}

variable "alarm_description" {
  type = string
  default = ""
}

variable "dimensions" {
  type = map(any)
}

variable "alarm_actions" {
  type = list
  default = []
}

variable "tags" {
  type = map(any)
  default = {
    Author : "Terraform"
  }
}
