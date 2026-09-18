terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}

resource "cloudflare_dns_record" "main" {
  zone_id = var.zone_id
  name    = var.name
  type    = var.type
  content = var.content
  ttl     = var.ttl
  proxied = var.proxied
  comment = var.comment
}
