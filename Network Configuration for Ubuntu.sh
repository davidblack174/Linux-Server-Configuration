#!/bin/bash
#--------------------------------------#
#   Created by: David Odediran
#           Date: 10/10/2021
#--------------------------------------#
#--------------------------------------#
#        What this script does
#--------------------------------------#
# This script is used to harden the network and server security of a Linux server.
# It installs and configures the UFW (Uncomplicated Firewall) and applies additional security measures.
#--------------------------------------#

# Update and upgrade the system for Ubuntu and Debian
sudo apt update && sudo apt upgrade -y

# Install UFW (Uncomplicated Firewall) for Ubuntu and Debian
sudo apt install ufw -y

# Allow SSH (replace 22 with your custom SSH port if needed)
SSH_PORT=22

#Allow SSH (replace 22 with your custom SSH port if needed) for fedora, CentOS, Amazon Linux and RHEL
sudo ufw allow $SSH_PORT

# Allow HTTP and HTTPS
sudo ufw allow 80
sudo ufw allow 443

# Block unused ports (list of ports to be blocked) for UFW in ubuntu and debian
# Example: BLOCK_PORTS="80 443"
BLOCK_PORTS="8080 8443 3306 5432 27017 27018 27019 28017 500"       # Add more ports as needed

# Block unused ports (list of ports to be blocked)   
for port in $BLOCK_PORTS; do    
  ufw deny $port/tcp    # Block the port
done

# Enable UFW
sudo ufw enable

#SSH Configuration Hardening
SSH_CONFIG="/etc/ssh/sshd_config"   # SSH configuration file

# Backup existing SSH config
cp $SSH_CONFIG $SSH_CONFIG.bak  # Backup the SSH configuration file

# Add AllowUsers entries for valid usernames
while IFS=: read -r username _; do
    if getent passwd "$username" > /dev/null; then
        echo "AllowUsers $username" >> $SSH_CONFIG
    fi
done < /etc/passwd

# Disable root login
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' $SSH_CONFIG    # Disable root login

# Disable password authentication (only allow key-based authentication)
sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' $SSH_CONFIG

# Restart SSH service
sudo systemctl restart sshd

# Enable UFW logging
sudo ufw logging on

# Display UFW status
sudo ufw status verbose

# Display message
echo "Network configuration has been completed successfully."


#--------------------------------------#
# Additional Security Measures (Optional)
# Uncomment the following lines to apply additional security measures

# 1. Disable unused network filesystems
# echo "install cramfs /bin/true" >> /etc/modprobe.d/disablefs.conf
# echo "install freevxfs /bin/true" >> /etc/modprobe.d/disablefs.conf
# echo "install jffs2 /bin/true" >> /etc/modprobe.d/disablefs.conf
# echo "install hfs /bin/true" >> /etc/modprobe.d/disablefs.conf
# echo "install hfsplus /bin/true" >> /etc/modprobe.d/disablefs.conf
# echo "install squashfs /bin/true" >> /etc/modprobe.d/disablefs.conf
# echo "install udf /bin/true" >> /etc/modprobe.d/disablefs.conf

# 2. Disable IPv6 if not needed
# echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
# echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
# sysctl -p
#--------------------------------------#


