# modules/network/main.tf - Módulo de Network

# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  
  tags = {
    Name = "vpc-main"
  }
}

# INTERNET GATEWAY
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  
  tags = {
    Name = "igw-main"
  }
}

# SUBNET
resource "aws_subnet" "sn_public" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_cidr_block
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone
  
  tags = {
    Name = "subnet-public"
  }
}

# ROUTE TABLE
resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  
  tags = {
    Name = "rt-public"
  }
}

# SUBNET ASSOCIATION
resource "aws_route_table_association" "rt_public_to_sn_public" {
  subnet_id      = aws_subnet.sn_public.id
  route_table_id = aws_route_table.rt_public.id
}

# SECURITY GROUP
resource "aws_security_group" "sg_public" {
  name   = "sg_public"
  vpc_id = aws_vpc.vpc.id
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr_block]
  }
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "sg-public"
  }
}