variable "ami" {
  default = null
}

variable "instance_type" {
  default = "t2.micro"
  type    = string
}

variable "subnet_id" {
  default = null
}

variable "security_groups" {
  type    = list(any)
  default = []
}

variable "key_name" {
  default = null
}

variable "associate_public_ip_address" {
  type    = bool
  default = false
}

variable "associate_elastic_ip" {
  default = false
  type = bool
}

variable "iam_instance_profile" {
  default = null
}

variable "root_block_volume_type" {
  default = "gp3"
}

variable "root_block_volume_size" {
  default = 30
}

variable "tags" {
  type = map(any)
  default = {
    Author : "Terraform"
  }
}
