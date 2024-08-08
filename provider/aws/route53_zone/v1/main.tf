resource "aws_route53_zone" "main" {
  name = "${var.name}"
  comment = "${var.comment}"
  tags = "${var.tags}"

  dynamic "vpc" {
    for_each = var.vpc_ids

    content {
      vpc_id     = vpc.value
    }
  }
  
}