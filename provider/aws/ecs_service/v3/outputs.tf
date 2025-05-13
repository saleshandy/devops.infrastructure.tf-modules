output "ecs_service_id" {
  value = "${aws_ecs_service.main.id}"
}

output "ecs_service_cluster" {
  value = "${aws_ecs_service.main.cluster}"
}

output "ecs_service_desired_count" {
  value = "${aws_ecs_service.main.desired_count}"
}

output "ecs_service_name" {
  value = "${aws_ecs_service.main.name}"
}