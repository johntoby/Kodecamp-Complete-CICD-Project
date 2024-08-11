#creating instance public instance
resource "aws_instance" "public_instance" {
  ami                         = var.ami
  instance_type               = var.instance_type
  availability_zone           = var.availability_zone
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  security_groups             = [var.security_group_id]
  associate_public_ip_address = true

  root_block_device {
    volume_type           = var.root_volume_type
    volume_size           = var.root_volume_size
    delete_on_termination = true
  }

  tags = {
    Name        = var.instance_name
    description = "webserver"
  }

  user_data = var.user_data
}

output "public_instance_public_ip" {
  value = aws_instance.public_instance.public_ip
}
