#!/bin/bash 

#--------------------------------------#
#   Created by: David Odediran
#           Date: 10/10/2021
#--------------------------------------#
#--------------------------------------#
#        What this script does
#--------------------------------------#
#This script is used to set up a new Linux server with the following configurations:
# 1. Update the system configuration
# 2. Install git
# 3. Create a new user and make them a sudoer
# 4. Create alias for all users
# 5. Set hostname
# 6. Git clone the network configuration script
# 7. Change directory to the cloned repository
# 8. Make the network configuration script executable
# 9. Launch the network configuration script
#--------------------------------------#

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
encrypted_password="$(openssl passwd -6 'david1234')"

sudo useradd -c "David Odediran" $username
sudo usermod -aG sudo $username
sudo echo "$username:$encrypted_password" | chpasswd -e
sudo echo "$username ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$username
#echo "User $username has been created and added to the sudo group with sudo privileges."

# Create alias for all users
echo "alias c='clear'" >> /etc/profile
echo "Alias 'c=clear' has been set for all users."

# Set hostname
hostname="CityCat-Server2024"  # Type your new hostname
sudo hostnamectl set-hostname $hostname
#echo "Hostname has been set to $hostname."

#Enter the user directory
cd /home/$username 

# Git clone the network configuration script
sudo git clone https://github.com/davidblack174/Linux-Server-Configuration

# Change directory to the cloned repository
cd Linux-Server-Configuration

# Make the network configuration script executable
chmod +x server-network-configuration-and-monitoring

# Launch the network configuration script
bash server-network-configuration-and-monitoring

#echo "Network configuration script has been executed."
