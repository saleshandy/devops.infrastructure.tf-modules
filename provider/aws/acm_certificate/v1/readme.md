*Example*

Wildcard certificate validated with DNS

```
module "example_wildcard_certificate" {
  source                    = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/aws/acm_certificate/v1"
  domain_name               = "*.example.com"
  subject_alternative_names = ["example.com"] # A wildcard does not cover the apex

  tags = {
    Name : "example-wildcard",
    Author : "Terraform",
  }
}

output "example_certificate_validation_records" {
  value = module.example_wildcard_certificate.validation_records
}
```

Notes

- The certificate is created in `PENDING_VALIDATION` and only becomes usable once the records in `validation_records` exist in DNS. ACM then issues it within minutes.
- `*.example.com` and `example.com` share one validation record, so the output map holds a single entry for both.
- When DNS is not in Route 53 (Cloudflare, for example), add the record by hand or with that provider; this module deliberately does not create DNS records.
- Certificates are regional. An ALB needs one in its own region; CloudFront needs one in us-east-1. They cannot be shared across accounts.
- ACM renews automatically as long as the validation record stays in place, so leave it there for the life of the certificate.
