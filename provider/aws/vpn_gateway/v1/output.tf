output "vpn_gateway_id" {
  description = "The ID of the VPN Gateway."
  value       = aws_vpn_gateway.main.id
}

output "vpn_gateway_arn" {
  description = "The ARN of the VPN Gateway."
  value       = aws_vpn_gateway.main.arn
}
