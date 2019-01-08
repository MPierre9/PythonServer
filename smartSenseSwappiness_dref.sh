#!/bin/bash
#
echo "Starting Script..."
sysctl -w vm.swappiness=0
swapoff -a
swapon -a
echo 0 > /proc/sys/vm/swappiness
sed -i -e '/vm.swappiness.\*/d' /etc/sysctl.conf && echo 'vm.swappiness = 0' >> /etc/sysctl.conf
echo "DONE"