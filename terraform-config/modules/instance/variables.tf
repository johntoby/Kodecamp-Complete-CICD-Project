variable "ami" {
  description = "AMI ID for the instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "availability_zone" {
  description = "The availability zone for the instance"
  type        = string
}

variable "key_name" {
  description = "The name of the SSH key pair"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the instance will be launched"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group for the instance"
  type        = string
}

variable "root_volume_type" {
  description = "Root block device volume type"
  type        = string
}

variable "root_volume_size" {
  description = "Root block device volume size"
  type        = number
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "user_data" {
  description = "User data script to configure the instance"
  type        = string
}
