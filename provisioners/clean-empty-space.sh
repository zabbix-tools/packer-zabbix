#!/bin/bash		

# Saves ~25M
echo "Removing unneeded packages..."
yum -y remove gcc cpp kernel-devel kernel-headers

# Clean cache
echo "Cleaning package cache..."
yum -y clean all

# Clean out all of the caching dirs
echo "Cleaning system caches..."
rm -rf /var/cache/* /usr/share/doc/*

# Clear wtmp
echo "Cleaning logs..."
history -c
cat /dev/null > /var/log/wtmp

# Clean up redhat interface persistence
# https://github.com/opscode/bento/blob/master/packer/scripts/centos/cleanup.sh
rm -f /etc/udev/rules.d/70-persistent-net.rules
if [ -r /etc/sysconfig/network-scripts/ifcfg-eth0 ]; then
  sed -i 's/^HWADDR.*$//' /etc/sysconfig/network-scripts/ifcfg-eth0
  sed -i 's/^UUID.*$//' /etc/sysconfig/network-scripts/ifcfg-eth0
fi

# Clean up unused disk space so compressed image is smaller.
echo "Zeroing out disk free space..."
dd if=/dev/zero of=/EMPTY bs=1M
rm -vf /EMPTY
