# modules/network/variables.tf - Variáveis do módulo de Network

variable "vpc_cidr_block" {
  description = "CIDR block para a VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "CIDR block para a subnet pública"
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "Availability Zone para os recursos"
  type        = string
  default     = "us-east-1a"
}