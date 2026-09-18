output "record_id" {
  value = cloudflare_dns_record.main.id
}

output "name" {
  value = cloudflare_dns_record.main.name
}

output "content" {
  value = cloudflare_dns_record.main.content
}
