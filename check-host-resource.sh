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

# Check for network interface
net_count=$(ls /sys/class/net | grep -v "lo" | wc -l)
if ((net_count < 1)); then
    echo "No network interfaces found. OpenStack requires at least one network interface (other than the loopback interface). Exiting."
    exit 1
fi

