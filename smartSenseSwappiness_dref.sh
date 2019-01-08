#!/bin/bash
#
echo "Starting Script..."
sysctl -w vm.swappiness=0
swapoff -a
swapon -a
echo 0 > /proc/sys/vm/swappiness
if grep -q "vm.swappiness.*" /etc/sysctl.conf; then
	echo "Parameter found."
	sed -i -e 's/vm.swappiness.*/vm.swappiness = 0/g' /etc/sysctl.conf
else
	echo "Parameter not found."
	echo "vm.swappiness = 0" >> /etc/sysctl.conf
fi
echo "DONE"