output "service_discovery_service_id" {
  value = "${aws_service_discovery_service.main.id}"
}

output "service_discovery_service_arn" {
  value = "${aws_service_discovery_service.main.arn}"
}