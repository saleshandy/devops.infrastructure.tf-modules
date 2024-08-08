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
    tags        = var.tags
  }

  iam_instance_profile = var.iam_instance_profile

  tags = var.tags
}
