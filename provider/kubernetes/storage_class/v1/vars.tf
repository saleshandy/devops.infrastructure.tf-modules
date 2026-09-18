variable "name" {
  type        = string
  description = "StorageClass name, as referenced by a PVC's storageClassName"
}

variable "provisioner" {
  type        = string
  description = "CSI driver backing the class, e.g. ebs.csi.aws.com or efs.csi.aws.com"
  default     = "ebs.csi.aws.com"
}

variable "parameters" {
  type        = map(string)
  description = "Driver-specific parameters, e.g. type, encrypted, kmsKeyId, fsType for the EBS CSI driver"
  default     = {}
}

variable "reclaim_policy" {
  type        = string
  description = "What happens to the volume when its PVC is deleted. Retain keeps the data; Delete removes it"
  default     = "Delete"

  validation {
    condition     = contains(["Retain", "Delete"], var.reclaim_policy)
    error_message = "reclaim_policy must be Retain or Delete."
  }
}

variable "volume_binding_mode" {
  type        = string
  description = "WaitForFirstConsumer provisions in the AZ the pod lands in; Immediate provisions at claim time"
  default     = "WaitForFirstConsumer"

  validation {
    condition     = contains(["WaitForFirstConsumer", "Immediate"], var.volume_binding_mode)
    error_message = "volume_binding_mode must be WaitForFirstConsumer or Immediate."
  }
}

variable "allow_volume_expansion" {
  type        = bool
  description = "Allow growing a volume by editing its PVC. Shrinking is never possible"
  default     = true
}

variable "is_default_class" {
  type        = bool
  description = "Use for PVCs that name no storageClassName. Only one class per cluster may set this"
  default     = false
}

variable "mount_options" {
  type        = list(string)
  description = "Mount options passed to the volume, e.g. [\"noatime\"]"
  default     = []
}

variable "labels" {
  type        = map(string)
  description = "Labels on the StorageClass object"
  default     = {}
}

variable "annotations" {
  type        = map(string)
  description = "Annotations on the StorageClass object, merged with the default-class annotation"
  default     = {}
}
