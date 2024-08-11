output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = module.vpc.public_subnet_id
}

output "public_instance_public_ip" {
  description = "Public IP of the public instance"
  value       = module.instance.public_instance_public_ip
}
