# modules/vm/outputs.tf - Outputs do módulo de VM

output "instance_id" {
  description = "ID da instância EC2 criada"
  value       = aws_instance.instance.id
}

output "instance_public_ip" {
  description = "IP público da instância EC2"
  value       = aws_instance.instance.public_ip
}

output "instance_private_ip" {
  description = "IP privado da instância EC2"
  value       = aws_instance.instance.private_ip
}