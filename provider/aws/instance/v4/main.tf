resource "aws_instance" "main" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_groups
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address

  root_block_device {
    volume_type = var.root_block_volume_type
    volume_size = var.root_block_volume_size
    iops        = var.root_block_volume_iops
    throughput  = var.root_block_volume_throughput
    # A key is only accepted on an encrypted volume. Without one, the account's EBS default applies
    encrypted  = var.root_block_volume_kms_key_id != null ? true : null
    kms_key_id = var.root_block_volume_kms_key_id
    tags       = var.tags
  }

  metadata_options {
    http_endpoint               = var.metadata_http_endpoint
    http_tokens                 = var.metadata_http_tokens
    http_put_response_hop_limit = var.metadata_http_put_response_hop_limit
    instance_metadata_tags      = var.metadata_instance_metadata_tags
  }

  iam_instance_profile = var.iam_instance_profile

  user_data                   = var.user_data
  user_data_base64            = var.user_data_base64
  user_data_replace_on_change = var.user_data_replace_on_change

  tags = var.tags
}
