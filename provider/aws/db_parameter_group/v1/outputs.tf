output "db_parameter_group_name" {
  value = "${aws_db_parameter_group.main.name}"
}

output "db_parameter_group_id" {
  value = "${aws_db_parameter_group.main.id}"
}