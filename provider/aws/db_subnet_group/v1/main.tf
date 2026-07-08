resource "aws_db_subnet_group" "main" {
  name = var.name
  # subnet_ids = ["subnet-8a052fe2", "subnet-2909ab52", "subnet-6bf86327"]
  subnet_ids = var.subnet_ids
  tags       = var.tags
}
