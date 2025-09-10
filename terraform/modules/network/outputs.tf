# modules/network/outputs.tf - Outputs do módulo de Network

output "vpc_id" {
  description = "ID da VPC criada"
  value       = aws_vpc.vpc.id
}

output "subnet_id" {
  description = "ID da subnet pública criada"
  value       = aws_subnet.sn_public.id
}

output "security_group_id" {
  description = "ID do security group criado"
  value       = aws_security_group.sg_public.id
}

output "internet_gateway_id" {
  description = "ID do Internet Gateway"
  value       = aws_internet_gateway.igw.id
}