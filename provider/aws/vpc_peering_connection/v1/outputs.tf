output "vpc_peering_connection_id" {
  value = aws_vpc_peering_connection.main.id
}

output "accept_status" {
  value = aws_vpc_peering_connection.main.accept_status
}
