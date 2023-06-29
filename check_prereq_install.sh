#!/bin/bash

# Verify CentOS Stream 9
if ! grep -q "CentOS Stream release 9" /etc/centos-release; then
    echo "This script requires CentOS Stream 9. Exiting."
    exit 1
fi

# Verify 8GB of memory
mem=$(grep MemTotal /proc/meminfo | awk '{print $2}')
if ((mem < 8000000)); then
    echo "This script requires at least 8 GB of memory. Exiting."
    exit 1
fi

# Update system
sudo dnf -y update

# Install prerequisite
sudo dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
sudo dnf -y install dnf-utils

# Enable PowerTools repository
sudo dnf config-manager --set-enabled powertools

# Install the RDO repository RPM
sudo dnf -y install https://www.rdoproject.org/repos/rdo-release.rpm

# Install Packstack Installer
sudo dnf -y install openstack-packstack

# Ask for user input
read -p "Do you want to proceed with the OpenStack installation (y/n)? " answer

case ${answer:0:1} in
    y|Y )
        # If yes, run Packstack to install OpenStack
        echo "Proceeding with OpenStack installation"
        packstack --allinone
    ;;
    * )
        # Else, exit the script
        echo "Exiting script without OpenStack installation."
        exit 1
    ;;
esac
