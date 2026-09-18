variable "name" {
  type        = string
  description = "Namespace name"
}

variable "labels" {
  type        = map(string)
  description = "Labels set at creation. Later changes made in-cluster are ignored"
  default     = {}
}

variable "annotations" {
  type        = map(string)
  description = "Annotations set at creation. Later changes made in-cluster are ignored"
  default     = {}
}

variable "delete_timeout" {
  type        = string
  description = "How long to wait for a delete. A namespace stuck terminating is usually a finalizer on a resource inside it"
  default     = "5m"
}
