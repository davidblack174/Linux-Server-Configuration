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
# Install git for Ubuntu and Debian
sudo apt-get update -y
sudo apt-get install git -y
echo "Git has been installed."

# Create a new user and make them a sudoer
username="david"    # Type your username

# Encrypted password using openssl to generate it
encrypted_password="$(openssl passwd -6 'david1234')"   # Type your password

sudo useradd -m -c "David Odediran" -s /bin/bash $username  # Type your full name and create a home directory for the user
sudo usermod -aG sudo $username     # Add user to the sudo group
echo "$username:$encrypted_password" | sudo chpasswd -e    # Set the password for the user

echo "PS1='\u@\h:\w\$ '" | sudo tee -a /home/$username/.bashrc    # Set the prompt for the user
sudo -u $username source /home/$username/.bashrc        # Source the bashrc file

echo "$username ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$username     # Give the user sudo privileges
echo "User $username has been created and added to the sudo group with sudo privileges."

# Create alias for all users
echo "alias c='clear'" >> /etc/profile   # Set alias for all users
echo "Alias 'c=clear' has been set for all users."  # Display message

# Set hostname
hostname="CityCat-Server2024"  # Type your new hostname
sudo hostnamectl set-hostname $hostname     # Set the hostname
echo "Hostname has been set to $hostname."

#Enter the user directory
cd /home/$username 

# Git clone the network configuration script
sudo git clone https://github.com/davidblack174/Linux-Server-Configuration

# Change directory to the cloned repository
cd Linux-Server-Configuration

# Make the network configuration script executable
chmod +x "Network-Configuration-for-Ubuntu.sh"

# Launch the network configuration script
sudo bash "Network-Configuration-for-Ubuntu.sh"

echo "Network configuration script has been executed."
