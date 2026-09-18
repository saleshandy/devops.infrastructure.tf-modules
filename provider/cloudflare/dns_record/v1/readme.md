*Example*

ACM certificate validation records in a Cloudflare-hosted zone

```
provider "cloudflare" {
  # Credentials come from the environment: CLOUDFLARE_API_TOKEN, or
  # CLOUDFLARE_API_KEY plus CLOUDFLARE_EMAIL for a global key. Never commit them.
}

data "cloudflare_zone" "example" {
  filter = { name = "example.com" }
}

module "example_certificate_validation" {
  source   = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/cloudflare/dns_record/v1"
  for_each = module.example_wildcard_certificate.validation_records

  zone_id = data.cloudflare_zone.example.zone_id
  name    = trimsuffix(each.key, ".")
  type    = each.value.type
  content = trimsuffix(each.value.value, ".")
  ttl     = 60
  proxied = false
  comment = "ACM validation for *.example.com"
}
```

Notes

- The provider is `cloudflare/cloudflare`, so this module declares it explicitly; Terraform would otherwise look for `hashicorp/cloudflare`.
- Pass credentials through the environment, never in code. A scoped API token (Zone > DNS > Edit) is safer than a global key.
- `proxied` must be false for anything that is not proxied HTTP traffic: certificate validation, MX, TXT and raw TCP endpoints. A proxied record also forces `ttl = 1`.
- ACM validation records must stay in place for the life of the certificate, because renewal revalidates through them.
- Names take no trailing dot; strip the one AWS includes with `trimsuffix(..., ".")`.
