variable "zone_id" {
  type = string
}

variable "name" {
  type = string
} 

variable "type" {
  type = string
}

variable "ttl" {
  type = number
  default = 10
}

variable "records" {
  type = list
}