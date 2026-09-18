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
