output "ecs_task_definition_arn" {
  value = "${aws_ecs_task_definition.main.arn}"
}

output "ecs_task_definition_revision" {
  value = "${aws_ecs_task_definition.main.revision}"
}

output "ecs_task_definition_tags_all" {
  value = "${aws_ecs_task_definition.main.tags_all}"
}