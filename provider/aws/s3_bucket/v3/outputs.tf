output "s3_bucket_bucket" {
  value = aws_s3_bucket.main.id
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.main.arn
}

output "s3_bucket_website_endpoint" {
  value = var.static_website ? aws_s3_bucket_website_configuration.main[0].website_endpoint : null
}
