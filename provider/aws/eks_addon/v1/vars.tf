variable "cluster_name" {
  type        = string
  description = "EKS cluster to install the addon into"
}

variable "addon_name" {
  type        = string
  description = "Addon name as EKS knows it, e.g. metrics-server, vpc-cni, coredns, kube-proxy, aws-ebs-csi-driver"
}

variable "addon_version" {
  type        = string
  description = "Exact addon version. Null takes whatever AWS currently defaults to for the cluster's Kubernetes version, which can change under you — pin it"
  default     = null
}

variable "resolve_conflicts_on_create" {
  type        = string
  description = "What to do if the addon's objects already exist: OVERWRITE or NONE"
  default     = "OVERWRITE"

  validation {
    condition     = contains(["OVERWRITE", "NONE"], var.resolve_conflicts_on_create)
    error_message = "resolve_conflicts_on_create must be OVERWRITE or NONE."
  }
}

variable "resolve_conflicts_on_update" {
  type        = string
  description = "What to do with fields changed outside the addon on update. PRESERVE keeps them, OVERWRITE discards them"
  default     = "PRESERVE"

  validation {
    condition     = contains(["OVERWRITE", "PRESERVE", "NONE"], var.resolve_conflicts_on_update)
    error_message = "resolve_conflicts_on_update must be OVERWRITE, PRESERVE or NONE."
  }
}

variable "service_account_role_arn" {
  type        = string
  description = "IRSA role for addons that call AWS APIs (the EBS CSI driver, VPC CNI). Not needed for metrics-server or CoreDNS"
  default     = null
}

variable "configuration_values" {
  type        = string
  description = "Addon configuration as a JSON string, e.g. jsonencode({ resources = { requests = { cpu = \"100m\" } } })"
  default     = null
}

variable "preserve_on_delete" {
  type        = bool
  description = "Leave the addon's Kubernetes objects running when the addon is removed from EKS. Useful when handing an addon over to Helm"
  default     = false
}

variable "tags" {
  type = map(string)
  default = {
    Author : "Terraform"
  }
}
