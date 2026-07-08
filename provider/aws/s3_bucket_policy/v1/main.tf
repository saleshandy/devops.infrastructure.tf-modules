resource "aws_s3_bucket_policy" "main" {
  bucket = var.bucket
  policy = var.policy
}