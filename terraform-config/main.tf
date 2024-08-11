#provider and region 
provider "aws" {
  region = var.aws_region
}

#creating vpc
module "vpc" {
  source                           = "./modules/vpc"
  vpc_cidr_block                   = var.vpc_cidr_block
  public_subnet_cidr_block         = var.public_subnet_cidr_block
  availability_zone                = var.availability_zone
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = false
  vpc_name                         = var.vpc_name
  internet_gateway_name            = var.internet_gateway_name
  public_route_table_name          = var.public_route_table_name
  public_subnet_name               = var.public_subnet_name
  public_sg_name                   = var.public_sg_name
}

#generating ssh-key locally 
resource "aws_key_pair" "kc-keypair" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

#creating instance public instance
module "instance" {
  source            = "./modules/instance"
  ami               = var.ami
  instance_type     = var.instance_type
  availability_zone = var.availability_zone
  key_name          = aws_key_pair.kc-keypair.id
  subnet_id         = module.vpc.public_subnet_id
  security_group_id = module.vpc.public_sg_id
  root_volume_type  = var.root_volume_type
  root_volume_size  = var.root_volume_size
  instance_name     = var.instance_name
  user_data         = var.user_data
}
