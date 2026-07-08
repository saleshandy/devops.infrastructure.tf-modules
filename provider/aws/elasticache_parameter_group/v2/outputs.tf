output "elasticache_parameter_group_id" {
  value = "${aws_elasticache_parameter_group.main.id}"
}

output "elasticache_parameter_group_arn" {
  value = "${aws_elasticache_parameter_group.main.arn}"
}

output "elasticache_parameter_group_name" {
  value = "${aws_elasticache_parameter_group.main.name}"
}