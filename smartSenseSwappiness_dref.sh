#!/bin/bash
#
echo "Starting Script..."
sysctl -w vm.swappiness=0
swapoff -a
swapon -a
echo 0 > /proc/sys/vm/swappiness
grep -q "vm.swappiness.*" /etc/sysctl.conf
	sed -i -e 's/vm.swappiness.*/vm.swappiness = 0/g' /etc/sysctl.conf || echo "vm.swappiness = 0" >> /etc/sysctl.conf
echo "DONE"