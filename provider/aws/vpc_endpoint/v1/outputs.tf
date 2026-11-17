output "vpc_endpoint_id" {
  value = aws_vpc_endpoint.main.id
}

output "prefix_list_id" {
  description = "Gateway only: the service prefix list, usable in security group rules"
  value       = aws_vpc_endpoint.main.prefix_list_id
}

output "dns_entry" {
  description = "Interface only: the endpoint's DNS names"
  value       = aws_vpc_endpoint.main.dns_entry
}
