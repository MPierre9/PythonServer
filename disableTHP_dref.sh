#!/bin/bash
#
echo 'Starting Script...'
echo 'never' > /sys/kernel/mm/transparent_hugepage/enabled
echo 'never' > /sys/kernel/mm/transparent_hugepage/defrag
printf "[Unit]\nDescription=Disable Transparent Huge Pages (THP)\n\n[Service]\nType=simple\nExecStart=/bin/sh -c \"echo 'never' > /sys/kernel/mm/transparent_hugepage/enabled && echo 'never' > /sys/kernel/mm/transparent_hugepage/defrag\"\n\n[Install]\nWantedBy=multi-user.target" > /etc/systemd/system/disable-thp.service
systemctl daemon-reload
systemctl start disable-thp
systemctl enable disable-thp
echo "DONE"