#!/bin/bash
echo "Configuring services..."

# Disable unneeded services
chkconfig vboxadd-x11 off

# Enable needed services
systemctl enable sshd
systemctl enable autofs
systemctl enable ntpdate

# Disable SELinux
sed -i -e 's/^SELINUX=.*/SELINUX=permissive/' /etc/selinux/config
