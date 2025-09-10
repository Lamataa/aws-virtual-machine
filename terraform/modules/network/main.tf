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

# SECURITY GROUP - Empty base group
resource "aws_security_group" "sg_public" {
  name        = "sg_public"
  description = "Security group for public instances with controlled access via separate rules"
  vpc_id      = aws_vpc.vpc.id
  
  tags = {
    Name = "sg-public"
  }
}

# EGRESS RULE
resource "aws_security_group_rule" "egress_all" {
  type              = "egress"
  description       = "Allow all outbound traffic"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_public.id
}

# INGRESS RULE - VPC Internal
resource "aws_security_group_rule" "ingress_vpc" {
  type              = "ingress"
  description       = "Allow internal VPC communication"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [var.vpc_cidr_block]
  security_group_id = aws_security_group.sg_public.id
}

# INGRESS RULE - HTTP
resource "aws_security_group_rule" "ingress_http" {
  type              = "ingress"
  description       = "Allow HTTP traffic from internet"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_public.id
}

# OPTIONAL SSH RULE - Only created if IP is provided
resource "aws_security_group_rule" "ssh_access" {
  count             = var.allowed_ssh_cidr != "" ? 1 : 0
  type              = "ingress"
  description       = "Allow SSH access from specific IP address"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.allowed_ssh_cidr]
  security_group_id = aws_security_group.sg_public.id
}