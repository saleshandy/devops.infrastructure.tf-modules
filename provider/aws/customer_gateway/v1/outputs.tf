output "customer_gateway_id" {
  value = "${aws_customer_gateway.main.id}"
}

output "customer_gateway_arn" {
  value = "${aws_customer_gateway.main.arn}"
}