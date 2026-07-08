# AWS EC2 Instance Module - v2

Terraform module to create an AWS EC2 instance with user_data support.

## Usage

```hcl
module "ec2_instance" {
  source = "github.com/opsonspot/terraform-modules/provider/provider/aws/instance/v2"

  ami                         = "ami-0c55b159cbfafe1f0"
  instance_type               = "t3.micro"
  subnet_id                   = "subnet-12345678"
  security_groups             = ["sg-12345678"]
  key_name                    = "my-key-pair"
  associate_public_ip_address = true
  iam_instance_profile        = "my-instance-profile"

  # User data script
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
  EOF

  user_data_replace_on_change = true

  root_block_volume_type = "gp3"
  root_block_volume_size = 30

  tags = {
    Name        = "my-instance"
    Environment = "production"
  }
}
```

## Outputs

```hcl
output "instance_id" {
  value = module.ec2_instance.instance_id
}

output "instance_arn" {
  value = module.ec2_instance.instance_arn
}
```
