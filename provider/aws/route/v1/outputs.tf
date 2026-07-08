output "is_gateway_route_id" {
    value = "${var.is_gateway}"?"${aws_route.main_gateway_id[0].id}":""
}

output "is_nat_gateway_route_id" {
    value = "${var.is_nat_gateway}"?"${aws_route.main_nat_gateway_id[0].id}":""
}

output "is_vpc_peering_connection_id" {
    value = "${var.is_vpc_peering_connection}"?"${aws_route.main_vpc_peering_connection_id[0].id}":""
}