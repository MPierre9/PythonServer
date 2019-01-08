#!/bin/bash
#
echo "Starting Script..."
sysctl -w vm.swappiness=0
swapoff -a
swapon -a
echo 0 > /proc/sys/vm/swappiness
grep -1 
	sed -i -e 's/vm.swappiness.*/vm.swappiness = 0/g' /etc/sysctl.conf || echo "vm.swappiness = 0" >> /etc/sysctl.conf
echo "DONE"