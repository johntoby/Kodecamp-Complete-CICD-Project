variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for the resources"
  type        = string
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
}

variable "assign_generated_ipv6_cidr_block" {
  description = "Assign generated IPv6 CIDR block to the VPC"
  type        = bool
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
}

variable "internet_gateway_name" {
  description = "Name tag for the Internet Gateway"
  type        = string
}

variable "public_route_table_name" {
  description = "Name tag for the public route table"
  type        = string
}

variable "public_subnet_name" {
  description = "Name tag for the public subnet"
  type        = string
}

variable "public_sg_name" {
  description = "Name tag for the public security group"
  type        = string
}
