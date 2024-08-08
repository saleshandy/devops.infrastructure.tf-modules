variable "name" {
    default = ""
    type = string
}

variable "enableContainerInsights" {
    type = bool
    default = false
}

variable "capacity_providers" {
    type = list
    default = ["FARGATE","FARGATE_SPOT"]
}

variable "tags" {
    type = map(any)
    default = {
        Author : "Terraform"
    }
}