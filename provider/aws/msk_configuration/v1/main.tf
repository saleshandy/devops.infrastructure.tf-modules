resource "aws_msk_configuration" "main" {
  kafka_versions = var.kafka_versions
  name           = var.name

  server_properties = var.server_properties
}
