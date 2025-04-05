#!/bin/bash
set -e  # Exit on any error

# Install dependencies
sudo yum install -y yum-utils device-mapper-persistent-data lvm2 || sudo yum install -y --nogpgcheck yum-utils device-mapper-persistent-data lvm2

# Add Docker repository
sudo dnf config-manager --add-repo=https://download.docker.com/linux/rhel/docker-ce.repo

# Install Docker
sudo dnf install -y docker-ce docker-ce-cli containerd.io || sudo yum install -y --nogpgcheck docker-ce docker-ce-cli containerd.io

# Start and enable Docker
sudo systemctl start docker
sudo systemctl enable docker

# Verify Docker status
sudo systemctl is-active --quiet docker && echo "Docker is running" || echo "Docker is NOT running"

# Add Jenkins user to Docker group
sudo usermod -aG docker jenkins

# Restart Docker service
sudo systemctl restart docker
sleep 5

# Verify Docker
sudo docker --version
sudo docker ps || echo "No running containers"

# Ensure script exits cleanly
echo "Script execution completed."
exit 0

sudo systemctl restart jenkins
