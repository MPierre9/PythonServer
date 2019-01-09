#!/bin/bash
#
echo "Starting Script..."

# Temporarily set vm.swappiness to zero
echo 10 > /proc/sys/vm/swappiness

# Scan and remove all, if any, instances of vm.swappiness
sed -i 's/vm.swappiness.*//g' /etc/sysctl.d/*
touch /etc/sysctl.d/vm_swappiness.conf
echo 'vm.swappiness = 10' >> /etc/sysctl.d/vm_swappiness.conf
echo "DONE"