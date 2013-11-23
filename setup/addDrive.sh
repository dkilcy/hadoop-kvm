#!/bin/bash
#
##############################################################################
# This software is provided AS-IS with no copyright, warranty or support.
# Since it has no copyright, if you can make money with it, good for you.
# If you mess up your system with this then that's on you.
# Email bug reports, suggested improvements or other comments to:
#       david@kilcyconsulting.com
# All email sent to the above address becomes the property of David Kilcy.
# If you do not agree to these terms then do not use this software.
# You are free to use, modify or distribute this software as long as this 
# header remains in place without modification and you agree to it's terms.
##############################################################################
# @author dkilcy
#
# Create data VG and mount disk
#
# Tested on CentOS 6.4
#

DISK=/dev/sdb

echo "Remove exit call when ready to turn up"
exit

if [ $USER != "root" ]; then echo "Must be run as root, aborting."; exit -1; fi 

echo "Start of program"

echo "Drive is $DISK"

echo "Create /data directory and set sticky bit"
mkdir -p /data
chmod 1777 /data

parted -l
pvcreate $DISK
vgcreate vg_server1_data $DISK
vgchange -a y vg_server1_data
lvcreate -l 100%FREE -n lv_data vg_server1_data
mkfs -t ext4 -j -L /data /dev/vg_server1_data/lv_data
mount /dev/vg_server1_data/lv_data /data

echo "/dev/mapper/vg_server1_data-lv_data /data       ext4    defaults        0 1" >> /etc/fstab

echo "Create /data/software directory and set sticky bit..."
mkdir -p /data/software
chmod 1777 /data/software

echo "Running some performance measurements..."

echo "Measuring write performance..."
dd if=/dev/zero of=/data/output.img bs=8k count=256k 

echo "Measuring read performance..."
dd if=/data/output.img of=/dev/null bs=4096k      

echo "End of program"
#
# References:
#
