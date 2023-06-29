#!/bin/bash

# Update system first
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
        # If yes, run Packstack to install OpenStack in debug mode
        echo "Proceeding with OpenStack installation"
        packstack --allinone --debug
    ;;
    * )
        # Else, exit the script
        echo "Exiting script without OpenStack installation."
        exit 1
    ;;
esac
