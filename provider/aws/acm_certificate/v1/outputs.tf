output "certificate_arn" {
  value = aws_acm_certificate.main.arn
}

output "domain_name" {
  value = aws_acm_certificate.main.domain_name
}

output "status" {
  value = aws_acm_certificate.main.status
}

output "validation_records" {
  description = "DNS records to create so ACM can validate the certificate, keyed by record name"
  value = {
    for o in aws_acm_certificate.main.domain_validation_options :
    o.resource_record_name => {
      type  = o.resource_record_type
      value = o.resource_record_value
    }
  }
}
