variable "name" {
  type        = string
  description = "Zone name, e.g. example.com or trulyinbox.lynx"
}

variable "vpc_ids" {
  type        = list(string)
  description = "VPCs to associate at creation, which makes this a private zone. Only applied on create — see the lifecycle note in main.tf"
  default     = []
}

variable "comment" {
  type        = string
  description = "Zone comment"
  default     = ""
}

variable "tags" {
  type = map(string)
  default = {
    Author : "Terraform"
  }
}
