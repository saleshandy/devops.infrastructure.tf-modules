
variable "capacity_providers" {
  description = "List of capacity providers to associate with the ECS cluster."
  type        = list(string)
  default     = ["FARGATE", "FARGATE_SPOT"]
}

variable "base" {
  type = number
  default = 1
}

variable "weight" {
  type = number
  default = 100
}

variable "capacity_provider" {
  type = string
  default = "FARGATE"
}

variable "cluster" {
  type    = string
  default = null
}
