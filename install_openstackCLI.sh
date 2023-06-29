#!/bin/bash

# Total stages
total_stages=5

# Update the system
echo "[1/${total_stages} - 20%] Updating system packages..."
sudo apt update -y

# Install Python3 and Python3-pip if they aren't installed
echo "[2/${total_stages} - 40%] Checking and installing Python3 if necessary..."
which python3 &> /dev/null || sudo apt install -y python3

echo "[3/${total_stages} - 60%] Checking and installing pip3 if necessary..."
which pip3 &> /dev/null || sudo apt install -y python3-pip

# Upgrade pip
echo "[4/${total_stages} - 80%] Upgrading pip..."
sudo pip3 install --upgrade pip

# Install the OpenStack client
echo "[5/${total_stages} - 100%] Installing the OpenStack client..."
sudo pip3 install python-openstackclient

echo "OpenStack client installation completed."
