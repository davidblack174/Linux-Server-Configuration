#! /bin/bash 

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
hostname="Server-Name"     #Type your new hostname
hostnamectl set-hostname $hostname
echo "Hostname has been set to $hostname."