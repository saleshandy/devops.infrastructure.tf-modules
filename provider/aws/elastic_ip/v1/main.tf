resource "aws_eip" "main" {
  tags = "${var.tags}"
}
