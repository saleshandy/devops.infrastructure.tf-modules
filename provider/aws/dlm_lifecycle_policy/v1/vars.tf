variable "description" {
  type        = string
  description = "Shown in the DLM console; the only human-readable label a policy has"
}

variable "execution_role_arn" {
  type        = string
  description = "Role DLM assumes. Needs the AWSDataLifecycleManagerServiceRole managed policy and a dlm.amazonaws.com trust"
}

variable "target_tags" {
  type        = map(string)
  description = "Volumes carrying all of these tags are snapshotted. An empty map would match everything, so it is required"
}

variable "schedules" {
  type        = any
  description = <<-EOT
    List of schedule objects:

      name            schedule name
      interval_hours  2, 3, 4, 6, 8, 12 or 24
      time            UTC start time as "HH:MM", within a one-hour window
      retain_count    how many snapshots to keep
      copy_tags       copy the volume's tags onto the snapshot, default true
      tags_to_add     extra tags for the snapshots themselves
  EOT
}

variable "resource_types" {
  type        = list(string)
  description = "VOLUME for per-volume snapshots, INSTANCE for multi-volume snapshots of an instance"
  default     = ["VOLUME"]
}

variable "enabled" {
  type    = bool
  default = true
}

variable "tags" {
  type    = map(string)
  default = { Author : "Terraform" }
}
