#!/bin/bash 

su root 
# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root"
  exit 1
fi

# Update the system configuration
# Install git for Fedora, Amazon Linux, and CentOS
sudo yum update -y
sudo yum install git -y
#echo "Git has been installed."

# Install git for Ubuntu and Debian
#sudo apt-get update -y
#sudo apt-get install git -y
#echo "Git has been installed."

# Create a new user and make them a sudoer
username="david"

# Encrypted password using openssl to generate it
encrypted_password="$(openssl passwd -6 'yourpasrd')"

sudo useradd --disabled-password --gecos "David Odediran" $username
sudo usermod -aG sudo $username
sudo echo "$username:$encrypted_password" | chpasswd -e
sudo echo "$username ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$username
#echo "User $username has been created and added to the sudo group with sudo privileges."

# Create alias for all users
sudo echo "alias c='clear'" >> /etc/profile
sudo echo "Alias 'c=clear' has been set for all users."

# Set hostname
hostname="CityCat-Server2024"  # Type your new hostname
hostnamectl set-hostname $hostname
#echo "Hostname has been set to $hostname."

# Git clone the network configuration script
git clone https://github.com/davidblack174/Linux-Server-Configuration

# Change directory to the cloned repository
cd Linux-Server-Configuration

# Make the network configuration script executable
chmod +x server-network-configuration-and-monitoring

# Launch the network configuration script
bash server-network-configuration-and-monitoring

#echo "Network configuration script has been executed."
