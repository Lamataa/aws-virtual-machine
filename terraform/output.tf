# outputs.tf - Outputs do módulo root

# Outputs do módulo network
output "vpc_id" {
  description = "ID da VPC"
  value       = module.network.vpc_id
}

output "subnet_id" {
  description = "ID da subnet pública"
  value       = module.network.subnet_id
}

# Outputs do módulo vm
output "instance_id" {
  description = "ID da instância EC2"
  value       = module.vm.instance_id
}

output "instance_public_ip" {
  description = "IP público da instância EC2"
  value       = module.vm.instance_public_ip
}