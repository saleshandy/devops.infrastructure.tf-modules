resource "aws_s3_bucket" "main" {
  bucket = var.bucket
  tags   = var.tags
}

resource "aws_s3_bucket_versioning" "main" {
  count  = var.versioning_configuration ? 1 : 0
  bucket = aws_s3_bucket.main.id

  versioning_configuration {
    status = var.versioning_status
  }
}

resource "aws_s3_bucket_cors_configuration" "main" {
  count  = var.cors_rule ? 1 : 0
  bucket = aws_s3_bucket.main.id

  cors_rule {
    allowed_headers = var.allowed_headers
    allowed_methods = var.allowed_methods
    allowed_origins = var.allowed_origins
    expose_headers  = var.expose_headers
    max_age_seconds = var.max_age_seconds
  }
}

resource "aws_s3_bucket_website_configuration" "main" {
  count  = var.static_website ? 1 : 0
  bucket = aws_s3_bucket.main.id

  index_document {
    suffix = var.index_document
  }

  error_document {
    key = var.error_document
  }

  routing_rules = var.routing_rules != "" ? var.routing_rules : null
}
