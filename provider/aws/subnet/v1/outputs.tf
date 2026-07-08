output "subnet_id" {
  value = "${aws_subnet.main.id}"
}

output "subnet_availability_zone" {
  value = "${aws_subnet.main.availability_zone}"
}

output "subnet_cidr_block" {
  value = "${var.cidr_block}"
}