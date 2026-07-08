output "instance_arn" {
  value = "${aws_instance.main.arn}"
}

output "instance_instance_state" {
  value = "${aws_instance.main.instance_state}"
}

output "instance_id" {
  value = "${aws_instance.main.id}"
}

output "instance_private_dns" {
  value = "${aws_instance.main.private_dns}"
}
