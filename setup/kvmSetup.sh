#!/bin/bash
#
##############################################################################
# This software is provided AS-IS with no copyright, warranty or support.
# Since it has no copyright, if you can make money with it, good for you.
# If you mess up your system with this then that's on you.
# Email bug reports, suggested improvements or other comments to:
# 	david@kilcyconsulting.com
# All email sent to the above address becomes the property of David Kilcy.
# If you do not agree to these terms then do not use this software.
# You are free to use, modify or distribute this software as long as this 
# header remains in place without modification and you agree to it's terms.
##############################################################################
# @author dkilcy
#
# Setup KVM Virtualization
#
# Tested on CentOS 6.4
#
# NOTES:
# set SELINUX=permissive in /etc/selinux/config
#

KVM_USER="dkilcy"

echo "Remove exit call when ready to turn up"
exit

if [ $USER != "root" ]; then echo "Must be run as root, aborting."; exit -1; fi 

echo "Start of program"

echo "KVM_USER is $KVM_USER"

##vmware-installer -u vmware-workstation
##rm -Rf /etc/vmware /var/lib/vmware /var/log/vmware /var/run/vmware

egrep '(vmx|svm)' --color=always /proc/cpuinfo

modprobe -l | grep kvm
/sbin/lsmod | grep kvm

yum groupinstall "Virtualization"
yum groupinstall "Virtualization Client"
yum groupinstall "Virtualization Platform"
yum groupinstall "Virtualization Tools"

## TODO: im not sure if this is needed...
yum install bridge-utils

usermod -G kvm -a $KVM_USER

virsh net-list --all
virsh net-autostart default
##virsh net-start default
brctl show

virsh -c qemu:///system list
chkconfig libvirtd on 
service libvirtd status
service NetworkManager status
service NetworkManager stop
chkconfig NetworkManager off
chkconfig network on
service network start 

## vi /etc/sysconfig/network-scripts/ifcfg-eth0
echo "BRIDGE=br0" >> /etc/sysconfig/network-scripts/ifcfg-eth0

## vi /etc/sysconfig/network-scripts/ifcfg-br0
echo "DEVICE=br0" > /etc/sysconfig/network-scripts/ifcfg-br0
echo "NM_CONTROLLED=yes" >> /etc/sysconfig/network-scripts/ifcfg-br0
echo "ONBOOT=yes" >> /etc/sysconfig/network-scripts/ifcfg-br0
echo "TYPE=Bridge" >> /etc/sysconfig/network-scripts/ifcfg-br0
echo "BOOTPROTO=dhcp" >> /etc/sysconfig/network-scripts/ifcfg-br0

# Notes:
# Applications->System Tools->Virtual Machine Manager
# When creating CentOS VM's, don't forget to set networking to auto-connect
#

echo "End of program"
#
# References:
#
