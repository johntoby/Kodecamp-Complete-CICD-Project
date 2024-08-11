#creating vpc
resource "aws_vpc" "vpc" {
  cidr_block                       = var.vpc_cidr_block
  instance_tenancy                 = "default"
  enable_dns_hostnames             = var.enable_dns_hostnames
  assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block
  tags = {
    Name = var.vpc_name
  }
}

#creating public subnet
resource "aws_subnet" "PublicSubnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = var.public_subnet_name
  }
}

#creating internet gateway
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.internet_gateway_name
  }
}

#creating public routing table
resource "aws_route_table" "publicRouteTable" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = {
    Name = var.public_route_table_name
  }
}

#association public routing table to subnet
resource "aws_route_table_association" "public_Subnet_Route_Table" {
  subnet_id      = aws_subnet.PublicSubnet.id
  route_table_id = aws_route_table.publicRouteTable.id
}

#creating security group for public instance
resource "aws_security_group" "public_sg" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.public_sg_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
  security_group_id = aws_security_group.public_sg.id
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
  security_group_id = aws_security_group.public_sg.id
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.public_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "all_traffic" {
  security_group_id = aws_security_group.public_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  from_port = 0
  to_port = 0
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.PublicSubnet.id
}

output "public_sg_id" {
  value = aws_security_group.public_sg.id
}
