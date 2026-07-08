resource "aws_security_group" "main" {
  name        = "${var.name}"
  description = "${var.description}"
  vpc_id      = "${var.vpc_id}"

  dynamic "ingress" {
    for_each = "${var.ingress_rules}" 

    content {
      from_port  = "${ingress.value.from}"
      to_port = "${ingress.value.to}"
      protocol = "${ingress.value.protocol}"
      cidr_blocks = "${ingress.value.cidr}"
      security_groups = "${ingress.value.security_groups}"
    }
  }

  dynamic "egress" {
    for_each = "${var.egress_rules}" 

    content {
      from_port  = "${egress.value.from}"
      to_port = "${egress.value.to}"
      protocol = "${egress.value.protocol}"
      cidr_blocks = "${egress.value.cidr}"
    }
  }

  tags = "${var.tags}"
}
