output "s3_bucket_bucket" {
  value = "${aws_s3_bucket.main.id}"
}

output "s3_bucket_arn" {
  value = "${aws_s3_bucket.main.arn}"
}