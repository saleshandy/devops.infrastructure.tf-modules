variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster"
}

variable "node_group_name" {
  type        = string
  description = "The name of the cluster node group. Also used as the launch template name."
}

variable "node_role_arn" {
  type        = string
  description = "ARN of the IAM role the worker nodes use"
}

variable "subnet_ids" {
  type = list(string)
}

variable "ami_type" {
  type        = string
  description = "AMI type of the node group, e.g. AL2023_x86_64_STANDARD, AL2023_ARM_64_STANDARD"
  default     = "AL2023_x86_64_STANDARD"
}

variable "ami_release_version" {
  type        = string
  description = "AMI release version of the node group. Defaults to latest version for the cluster Kubernetes version"
  default     = null
}

variable "instance_types" {
  type        = list(string)
  description = "List of instance types associated with the node group"
  default     = null
}

variable "capacity_type" {
  type        = string
  description = "Type of capacity associated with the node group. Valid values: ON_DEMAND, SPOT."
  default     = "ON_DEMAND"
}

variable "disk_size" {
  type        = number
  description = "Root volume size in GiB (gp3, encrypted)"
  default     = 20
}

variable "desired_size" {
  type    = number
  default = 2
}

variable "max_size" {
  type    = number
  default = 10
}

variable "min_size" {
  type    = number
  default = 1
}

variable "max_unavailable_percentage" {
  type        = number
  description = "Max percentage of nodes unavailable during node group updates (1 = one node at a time)"
  default     = 1
}

variable "labels" {
  type        = map(string)
  description = "Key-value mapping of Kubernetes labels applied to the nodes"
  default     = {}
}

variable "taints" {
  type        = any
  description = "Map of taints, each with key, optional value and effect (NO_SCHEDULE, NO_EXECUTE, PREFER_NO_SCHEDULE)"
  default     = {}
}

variable "ec2_ssh_key" {
  type        = string
  description = "Optional EC2 key pair name set on the launch template"
  default     = null
}

variable "metadata_http_tokens" {
  type        = string
  description = "IMDS token mode: required (IMDSv2 only) or optional (IMDSv1 allowed)"
  default     = "required"
}

variable "metadata_hop_limit" {
  type        = number
  description = "IMDS PUT response hop limit. 2 lets pods (not only hostNetwork) reach IMDS"
  default     = 2
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to the node group, launch template, and every instance, volume and ENI it launches"
  default = {
    Author : "Terraform"
  }
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

variable "addon_create_ebs_csi_driver" {
  default = false
}

variable "addon_ebs_csi_driver_version" {
  default = ""
}

variable "addon_create_aws_guardduty_agent" {
  default = false
}

variable "addon_aws_guardduty_agent_version" {
  default = ""
}
