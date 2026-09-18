resource "aws_acm_certificate" "main" {
  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names
  validation_method         = var.validation_method
  key_algorithm             = var.key_algorithm

  tags = var.tags

  lifecycle {
    # Replacements must issue before the old certificate is removed from listeners
    create_before_destroy = true
  }
}

locals {
  # A wildcard and its apex share one validation record, so group by record name to avoid
  # duplicate keys, then keep the first of each group
  validation_records_grouped = {
    for o in aws_acm_certificate.main.domain_validation_options :
    o.resource_record_name => {
      type  = o.resource_record_type
      value = o.resource_record_value
    }...
  }
}
