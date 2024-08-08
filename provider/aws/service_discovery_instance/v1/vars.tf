variable "instance_id" {
    default = ""
}

variable "service_id" {
  default = ""
}

variable "attributes" {
    type = map(any)
    default = null
}