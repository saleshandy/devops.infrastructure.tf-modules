output "lb_target_group_id" {
  value = "${aws_lb_target_group.main.id}"
}

output "lb_target_group_arn" {
  value = "${aws_lb_target_group.main.arn}"
}

output "lb_target_group_name" {
  value = "${aws_lb_target_group.main.name}"
}