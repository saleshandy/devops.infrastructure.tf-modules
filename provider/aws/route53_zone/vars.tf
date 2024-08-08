variable "vpc_id" {
  description = "VPC ID of our private hosted zone"
  default     = ""
}
variable "name" {
  description = "Name of our Route53 public hosted zone"
  type = string
  # default     = ""
}
variable "comment" {
  description = "Description of our Route53 public hosted zone"
  type = string
  default     = ""
}
variable "tags" {
    type = map(any)
    default = {
        Author : "Terraform"
        Contact_Person: "Aman Makwana"
    }
}

variable "private_zone" {
  type = bool
  default = false
}