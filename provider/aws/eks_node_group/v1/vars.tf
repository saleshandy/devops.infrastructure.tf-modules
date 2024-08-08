variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster"
}

variable "node_group_name" {
  type        = string
  description = "The name of the cluster node group."
}

variable "node_role_arn" {}

variable "subnet_ids" {
  type = list(string)
}

variable "ami_type" {
  type        = string
  description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Valid values: `AL2_x86_64`, `AL2_x86_64_GPU`. Terraform will only perform drift detection if a configuration value is provided"
  default     = null
}

variable "disk_size" {
  type        = number
  description = "Disk size in GiB for worker nodes. Defaults to 20. Terraform will only perform drift detection if a configuration value is provided"
  default     = null
}

variable "instance_types" {
  type        = list(string)
  description = "List of instance types associated with the EKS Node Group. Terraform will only perform drift detection if a configuration value is provided"
  default     = null
}


variable "capacity_type" {
  type        = string
  description = "Type of capacity associated with the EKS Node Group. Defaults to ON_DEMAND. Valid values: ON_DEMAND, SPOT."
  default     = "ON_DEMAND"
}

variable "labels" {
  type        = map(string)
  description = "Key-value mapping of Kubernetes labels. Only labels that are applied with the EKS API are managed by this argument. Other Kubernetes labels applied to the EKS Node Group will not be managed"
  default     = {}
}

variable "ami_release_version" {
  type        = string
  description = "AMI version of the EKS Node Group. Defaults to latest version for Kubernetes version"
  default     = null
}


variable "tags" {
    type = map(any)
    default = {
        Author : "Terraform"
    }
}


variable "desired_size" {
  default = 2
}

variable "max_size" {
  default = 10
}

variable "min_size" {
  default = 1
}

variable "ec2_ssh_key" {
  default = null
}

variable "taint_key" {
  default = null
  type = string
}
variable "taint_value" {
  default = null
  type = string
}
variable "taint_effect" {
  default = "NO_SCHEDULE"
  type = string
}

variable "source_security_group_ids" {
  default = []
}

variable "addon_create_vpc_cni" {
  default = false
}

variable "addon_vpc_cni_version" {
  default = ""
}

variable "addon_create_kube_proxy" {
  default = false
}

variable "addon_kube_proxy_version" {
  default = ""
}

variable "addon_create_coredns" {
  default = false
}

variable "addon_coredns_version" {
  default = ""
}