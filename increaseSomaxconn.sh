#!/bin/bash
#

# Reference https://serverfault.com/questions/271380/how-can-i-increase-the-value-of-somaxconn
echo "Starting Script..."

# Temporarily set net to 8192
echo 8192 > /proc/sys/net/core/somaxconn

# Scan and remove all, if any, instances of net.core/somaxconn
sed -i -e '/^\.*net.core.somaxconn*$/d' /etc/sysctl.d/*
sed -i -e '/^\.*net.core.somaxconn*$/d' /usr/lib/sysctl.d/*

touch /etc/sysctl.d/net_core_somaxconn.conf
echo 'net.core.somaxconn = 8192' >> /etc/sysctl.d/net_core_somaxconn.conf
echo 'Complete.'