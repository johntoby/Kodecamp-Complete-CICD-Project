variable "aws_region" {
  description = "The AWS region to deploy the infrastructure"
  type        = string
  default     = "eu-west-1"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "The availability zone for resources"
  type        = string
  default     = "eu-west-1a"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "kcvpc"
}

variable "internet_gateway_name" {
  description = "Name of the Internet Gateway"
  type        = string
  default     = "kc_IGW"
}

variable "public_route_table_name" {
  description = "Name of the public route table"
  type        = string
  default     = "Kcvpc_public-route-table"
}

variable "public_subnet_name" {
  description = "Name of the public subnet"
  type        = string
  default     = "PublicSubnet"
}

variable "public_sg_name" {
  description = "Name of the security group for public instances"
  type        = string
  default     = "Public-SG"
}

variable "key_name" {
  description = "The name of the SSH key pair"
  type        = string
  default     = "kc-keypair"
}

variable "public_key_path" {
  description = "Path to the public key file"
  type        = string
  default     = "kc-keypair.pub"
}

variable "ami" {
  description = "AMI ID for the instance"
  type        = string
  default     = "ami-0c38b837cd80f13bb"
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.medium" 
}

variable "root_volume_type" {
  description = "Root block device volume type"
  type        = string
  default     = "gp3"
}

variable "root_volume_size" {
  description = "Root block device volume size"
  type        = number
  default     = 30
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
  default     = "kc-python-server"
}

variable "user_data" {
  description = "User data script to configure the instance"
  type        = string
  default     = <<-EOF
                    #!/bin/bash
                    # Update package list and install prerequisites
                    sudo apt-get update -y
                    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

                    # Install Docker
                    echo "Installing Docker..."
                    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
                    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
                    sudo apt-get update -y
                    sudo apt-get install -y docker-ce docker-ce-cli containerd.io

                    # Add current user to the docker group (logout and login again to apply)
                    sudo usermod -aG docker $USER
                    newgrp docker

                    # Install Minikube
                    echo "Installing Minikube..."
                    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
                    sudo install minikube-linux-amd64 /usr/local/bin/minikube
                    rm minikube-linux-amd64
                    #starting minikube
                    echo "stating minikube"
                    minikube start



                    # Install kubectl
                    echo "Installing kubectl..."
                    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
                    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
                    rm kubectl

                    # Verify installations
                    echo "Verifying installations..."

                    # Check Docker
                    docker --version
                    if [ $? -ne 0 ]; then
                        echo "Docker installation failed."
                    else
                        echo "Docker installed successfully."
                    fi

                    # Check Minikube
                    minikube version
                    if [ $? -ne 0 ]; then
                        echo "Minikube installation failed."
                    else
                        echo "Minikube installed successfully."
                    fi

                    # Check kubectl
                    kubectl version --client
                    if [ $? -ne 0 ]; then
                        echo "kubectl installation failed."
                    else
                        echo "kubectl installed successfully."
                    fi

                    echo "Installation of Docker, Minikube, and kubectl is complete."

                    # Note to the user
                    echo "You may need to log out and log back in for Docker group changes to take effect."

                  EOF
}
