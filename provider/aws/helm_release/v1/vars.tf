variable "name" {
  type        = string
  description = "Release name"
}

variable "namespace" {
  type        = string
  description = "Namespace to install into"
}

variable "create_namespace" {
  type    = bool
  default = true
}

variable "repository" {
  type        = string
  description = "Chart repository URL. Null for a local path or an OCI reference in chart"
  default     = null
}

variable "chart" {
  type        = string
  description = "Chart name in the repository, a local path, or an oci:// reference"
}

variable "chart_version" {
  type        = string
  description = "Exact chart version. Always pin it"
}

variable "values" {
  type        = list(string)
  description = "Values as YAML strings, merged in order; use yamlencode() to build them"
  default     = []
}

variable "set" {
  type = list(object({
    name  = string
    value = string
    type  = optional(string)
  }))
  description = "Individual value overrides applied after values"
  default     = []
}

variable "atomic" {
  type        = bool
  description = "Roll back the release if install or upgrade fails"
  default     = true
}

variable "cleanup_on_fail" {
  type    = bool
  default = true
}

variable "wait" {
  type        = bool
  description = "Wait until all resources are ready before marking the release successful"
  default     = true
}

variable "wait_for_jobs" {
  type    = bool
  default = false
}

variable "timeout" {
  type        = number
  description = "Seconds to wait for the release"
  default     = 600
}

variable "max_history" {
  type        = number
  description = "Release revisions kept in history (0 keeps all)"
  default     = 10
}

variable "skip_crds" {
  type        = bool
  description = "Skip installing CRDs the chart ships. Helm never upgrades CRDs on release upgrade"
  default     = false
}
