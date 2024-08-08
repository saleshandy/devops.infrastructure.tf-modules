resource "aws_route53_zone" "main" {
  name = "${var.name}"
  comment = "${var.comment}"
  tags = "${var.tags}"

  dynamic "vpc" {
    for_each = "${var.private_zone}" ? ["true"] : []

    content {
      vpc_id = "${var.vpc_id}"
    }
  }
  
}