# Módulo de Network
module "network" {
  source = "./modules/network"
  
  vpc_cidr_block     = "10.0.0.0/16"
  subnet_cidr_block  = "10.0.1.0/24"
  availability_zone  = "us-east-1a"
}

# Módulo de VM
module "vm" {
  source = "./modules/vm"
  
  # Passando outputs do módulo network como inputs
  vpc_id            = module.network.vpc_id
  subnet_id         = module.network.subnet_id
  security_group_id = module.network.security_group_id
  
  ami_id        = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
}