resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  bucket = var.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.kms_key_arn != null ? "aws:kms" : "AES256"
      kms_master_key_id = var.kms_key_arn
    }

    # S3 Bucket Keys cut KMS request volume (and cost) for SSE-KMS; not applicable to SSE-S3
    bucket_key_enabled = var.kms_key_arn != null ? var.bucket_key_enabled : null
  }
}
