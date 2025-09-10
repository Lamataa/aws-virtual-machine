# modules/vm/main.tf - Módulo de VM

# Template file para user data
data "template_file" "user_data" {
  template = file("${path.root}/scripts/user_data.sh")
}

# EC2 INSTANCE
resource "aws_instance" "instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  user_data_base64       = base64encode(data.template_file.user_data.rendered)
  
  tags = {
    Name = "instance-main"
  }
}