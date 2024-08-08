resource "aws_s3_bucket" "main" {
  bucket = var.bucket

  dynamic "cors_rule" {
    for_each = "${var.cors_rule}" ? ["true"] : []

    content {
      allowed_headers = var.allowed_headers
      allowed_methods = var.allowed_methods
      allowed_origins = var.allowed_origins
      expose_headers  = var.expose_headers
      max_age_seconds = var.max_age_seconds
    }
  }

  dynamic "website" {
    for_each = "${var.static_website}" ? ["true"] : []

    content {
      index_document = var.index_document
      error_document = var.error_document

      routing_rules = var.routing_rules
    }
  }
}

resource "aws_s3_bucket_versioning" "main" {
  count  = var.versioning_configuration ? 1 : 0
  bucket = var.bucket

  versioning_configuration {
    status = var.versioning_status
  }
}
