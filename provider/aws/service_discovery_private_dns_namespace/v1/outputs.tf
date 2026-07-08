output "service_discovery_private_dns_namespace_arn" {
  value = "${aws_service_discovery_private_dns_namespace.main.arn}"
}

output "service_discovery_private_dns_namespace_id" {
  value = "${aws_service_discovery_private_dns_namespace.main.id}"
}

output "service_discovery_private_dns_namespace_hosted_zone" {
  value = "${aws_service_discovery_private_dns_namespace.main.hosted_zone}"
}