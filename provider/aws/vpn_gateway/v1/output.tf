output "vpn_gateway_id" {
  description = "The ID of the VPN Gateway."
  value       = aws_vpn_gateway.vpn_gw.id
}
