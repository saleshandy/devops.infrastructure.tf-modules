output "lb_listener_id" {
  value = "${aws_lb_listener_rule.main.id}"
}

output "lb_listener_arn" {
  value = "${aws_lb_listener_rule.main.arn}"
}