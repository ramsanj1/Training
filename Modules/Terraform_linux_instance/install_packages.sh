#!/bin/bash

# Update package lists
sudo apt-get update

# Install Java
sudo apt-get install -y default-jre

# Install ansible
sudo apt install -y ansible

# Set the script as executable
chmod +x install_packages.sh
