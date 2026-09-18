output "id" {
  value = aws_route53_zone_association.main.id
}

output "zone_id" {
  value = aws_route53_zone_association.main.zone_id
}

output "vpc_id" {
  value = aws_route53_zone_association.main.vpc_id
}
