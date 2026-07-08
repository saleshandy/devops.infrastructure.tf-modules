variable "name" {
    default = ""
    type = string
}

variable "enableContainerInsights" {
    type = bool
    default = false
}

variable "tags" {
    type = map(any)
    default = {
        Author : "Terraform"
    }
}