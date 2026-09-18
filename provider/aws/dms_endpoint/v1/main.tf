resource "aws_dms_endpoint" "main" {
  endpoint_id   = var.name
  endpoint_type = var.endpoint_type
  engine_name   = var.engine_name

  server_name   = var.server_name
  port          = var.port
  database_name = var.database_name
  username      = var.username
  password      = var.password

  ssl_mode                    = var.ssl_mode
  extra_connection_attributes = var.extra_connection_attributes
  kms_key_arn                 = var.kms_key_arn

  tags = var.tags
}
