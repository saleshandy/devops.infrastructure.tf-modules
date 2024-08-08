output "route53_record_name" {
  value = "${aws_route53_record.main.name}"
}

output "route53_record_fqdn" {
  value = "${aws_route53_record.main.fqdn}"
}