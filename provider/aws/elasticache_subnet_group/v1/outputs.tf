output "elasticache_subnet_group_id" {
  value = "${aws_elasticache_subnet_group.main.id}"
}

output "elasticache_subnet_group_name" {
  value = "${aws_elasticache_subnet_group.main.name}"
}