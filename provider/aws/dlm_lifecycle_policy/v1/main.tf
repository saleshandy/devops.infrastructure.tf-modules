resource "aws_dlm_lifecycle_policy" "main" {
  description        = var.description
  execution_role_arn = var.execution_role_arn
  state              = var.enabled ? "ENABLED" : "DISABLED"

  policy_details {
    resource_types = var.resource_types
    target_tags    = var.target_tags

    dynamic "schedule" {
      for_each = var.schedules

      content {
        name      = schedule.value.name
        copy_tags = try(schedule.value.copy_tags, true)

        create_rule {
          interval      = schedule.value.interval_hours
          interval_unit = "HOURS"
          times         = [schedule.value.time]
        }

        retain_rule {
          count = schedule.value.retain_count
        }

        # Snapshots inherit nothing by default, so without this they are hard to attribute in a bill
        tags_to_add = try(schedule.value.tags_to_add, {})
      }
    }
  }

  tags = var.tags
}
