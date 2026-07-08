output "msk_configuration_arn" {
  value = "${aws_msk_configuration.main.arn}"
}

output "msk_configuration_latest_revision" {
  value = "${aws_msk_configuration.main.latest_revision}"
}