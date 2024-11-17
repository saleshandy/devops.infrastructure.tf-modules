
variable "capacity_providers" {
  description = "List of capacity providers to associate with the ECS cluster."
  type        = list(string)
  default     = ["FARGATE", "FARGATE_SPOT"]
}

variable "capacity_provider_strategy" {
  description = "The default capacity provider strategy for the ECS cluster."
  type = list(object({
    base              = number
    weight            = number
    capacity_provider = string
  }))
  default = [
    {
      base              = 1
      weight            = 100
      capacity_provider = "FARGATE"
    }
  ]
}

variable "cluster" {
  type    = string
  default = null
}
