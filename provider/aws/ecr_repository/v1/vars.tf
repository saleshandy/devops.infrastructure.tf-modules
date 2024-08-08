variable "name" {
  description = "Name of our ECR registery"
  # default     = ""
}
variable "image_tag_mutability" {
  description = "image tag mutability of docker images"
  # default     = ""
}
variable "scan_on_push" {
  description = "image vulnerability scanning"
  # default     = ""
  type = bool
}
