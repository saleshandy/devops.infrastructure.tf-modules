variable "bucket" {
  type = string
}


variable "cors_rule" {
  type    = bool
  default = false
}

variable "versioning_configuration" {
  type    = bool
  default = false
}

variable "versioning_status" {
  type    = string
  default = "Disabled"
}

variable "allowed_headers" {
  type    = list(any)
  default = ["*"]
}

variable "allowed_methods" {
  type    = list(any)
  default = ["get"]
}

variable "allowed_origins" {
  type    = list(any)
  default = ["*"]
}

variable "expose_headers" {
  type    = list(any)
  default = []
}

variable "max_age_seconds" {
  type    = number
  default = null
}

variable "static_website" {
  type    = bool
  default = false
}

variable "index_document" {
  type    = string
  default = "index.html"
}

variable "error_document" {
  type    = string
  default = "error.html"
}

variable "routing_rules" {
  default = ""
}