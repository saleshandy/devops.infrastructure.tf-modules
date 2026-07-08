output "route53_zone_arn" {
  value = "${aws_route53_zone.main.arn}"
}

output "route53_zone_zone_id" {
  value = "${aws_route53_zone.main.zone_id}"
}