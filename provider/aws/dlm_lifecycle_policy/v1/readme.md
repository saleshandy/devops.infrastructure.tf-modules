*Example*

```
module "example_dlm_role" {
  source = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/aws/iam_role/v2"
  name   = "example_dlm_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Action    = "sts:AssumeRole"
      Principal = { Service = "dlm.amazonaws.com" }
    }]
  })
}

module "example_dlm_role_policy_attachment" {
  source     = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/aws/iam_role_policy_attachment/v1"
  role       = module.example_dlm_role.iam_role_name
  policy_arn = ["arn:aws:iam::aws:policy/service-role/AWSDataLifecycleManagerServiceRole"]
}

module "example_daily_snapshots" {
  source             = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/aws/dlm_lifecycle_policy/v1"
  description        = "Daily snapshots of the example data volumes"
  execution_role_arn = module.example_dlm_role.iam_role_arn

  # Only volumes carrying this tag
  target_tags = {
    Backup = "example-daily"
  }

  schedules = [{
    name           = "daily"
    interval_hours = 24
    time           = "06:00"
    retain_count   = 7
  }]
}
```

Notes

- **`target_tags` is the whole safety mechanism.** A volume is snapshotted if it carries every tag listed, so a broad tag catches far more than intended — on an EKS cluster, filtering by something like `Environment` sweeps in every node root volume, which are rebuilt from the AMI and worth nothing as snapshots. Prefer a tag that exists only on the volumes you actually want.
- Node root volumes are usually the wrong thing to snapshot. The volumes worth keeping are the CSI-provisioned ones behind PersistentVolumeClaims, and those are tagged by the driver, not by the node group.
- `time` is a UTC start for a one-hour window, not an exact moment — DLM starts the snapshot somewhere inside that hour.
- `retain_count` is a count, not a duration. With `interval_hours = 24`, a count of 7 is roughly a week; change the interval and the meaning changes with it.
- EBS snapshots are incremental, so the second and later snapshots of a volume only bill for changed blocks. Retention is cheaper than it first looks, but a busy volume still accrues.
- Set `copy_tags` or `tags_to_add`, or the snapshots arrive untagged and cannot be attributed to a team or environment in the bill.
- The execution role must exist and carry the managed policy before the policy is created, or DLM rejects it.
