# modules/vm/variables.tf - Variáveis do módulo de VM

variable "vpc_id" {
  description = "ID da VPC onde a instância será criada"
  type        = string
}

variable "subnet_id" {
  description = "ID da subnet onde a instância será criada"
  type        = string
}

variable "security_group_id" {
  description = "ID do security group para a instância"
  type        = string
}

variable "ami_id" {
  description = "ID da AMI para a instância EC2"
  type        = string
  default     = "ami-0c101f26f147fa7fd"
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t2.micro"
}