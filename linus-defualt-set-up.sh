#!/bin/bash 

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root"
  exit 1
fi

# Create a new user and make them a sudoer
username="new-user"
adduser $username
usermod -aG sudo $username
echo "$username ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$username
echo "User $username has been created and added to the sudo group with sudo privileges."

# Create alias for all users
echo "alias c='clear'" >> /etc/profile
echo "Alias 'c=clear' has been set for all users."

# Set hostname
hostname="Server-Name"  # Type your new hostname
hostnamectl set-hostname $hostname
echo "Hostname has been set to $hostname."

# Git clone the network configuration script
git clone https://github.com/davidblack174/Linux-Server-Configuration

# Change directory to the cloned repository
cd Linux-Server-Configuration

# Make the network configuration script executable
chmod +x server-network-configuration-and-monitoring

# Launch the network configuration script
bash server-network-configuration-and-monitoring

#echo "Network configuration script has been executed."
