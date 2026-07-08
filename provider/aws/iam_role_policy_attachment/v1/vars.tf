variable "role" {}

variable "policy_arn" {
    description = "IAM Policies to be attached to role"
    type = list
}