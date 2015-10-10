#!/bin/bash

echo "Configuring networking..."

HOSTNAME="zabbix.local"
echo "HOSTNAME=$HOSTNAME" >> /etc/sysconfig/network
echo "$HOSTNAME" > /etc/hostname

cat > /etc/sysconfig/network-scripts/ifcfg-eth0 <<EOL
DEVICE=eth0
TYPE=Ethernet
ONBOOT=yes
NM_CONTROLLED=no
BOOTPROTO=dhcp
EOL

cat > /etc/sysconfig/network-scripts/ifcfg-eth1 <<EOL
DEVICE=eth1
TYPE=Ethernet
ONBOOT=no
NM_CONTROLLED=no
BOOTPROTO=dhcp
EOL
