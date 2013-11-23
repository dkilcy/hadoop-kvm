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
# Tested on CentOS 6.4
#

INSTALL_DIR="/opt"
HADOOP_VER1="hadoop-1.2.1"
HADOOP_VER2="hadoop-2.2.0"

echo "Remove exit call when ready to turn up"
#exit

if [ $USER != "root" ]; then echo "Must be run as root, aborting."; exit -1; fi 

echo "Start of program"

echo "INSTALL_DIR is $INSTALL_DIR"

##############################################################################
## Clean
##############################################################################

rm -Rf $INSTALL_DIR/hadoop*
userdel hadoop
rm -Rf /home/hadoop

##############################################################################

echo "HADOOP_VER1 is $HADOOP_VER1"

sleep 3

cd $INSTALL_DIR 

cp /data/software/$HADOOP_VER1.tar.gz $INSTALL_DIR
tar zxvf $HADOOP_VER1.tar.gz 
rm $HADOOP_VER1.tar.gz

ln -sf $INSTALL_DIR/$HADOOP_VER1 $INSTALL_DIR/hadoop

##############################################################################

echo "HADOOP_VER2 is $HADOOP_VER2"

cd $INSTALL_DIR

cp /data/software/$HADOOP_VER2.tar.gz $INSTALL_DIR
tar zxvf $HADOOP_VER2.tar.gz
rm $HADOOP_VER2.tar.gz

###ln -sf $INSTALL_DIR/$HADOOP_VER2 $INSTALL_DIR/hadoop

##############################################################################
# Common (master and slave) setup
##############################################################################

echo "Adding hadoop user and group..."
useradd hadoop
##passwd hadoop

echo "Appending env vars to /home/hadoop/.bash_profile"
echo "" >> /home/hadoop/.bash_profile
echo "##############################################################################" >> /home/hadoop/.bash_profile
echo "# Appended by $0 at `date`"  >> /home/hadoop/.bash_profile
echo "##############################################################################" >> /home/hadoop/.bash_profile
echo "" >> /home/hadoop/.bash_profile
echo "PS1=\"\e[1;33m[\u@\h \W]$ \e[m\"" >> /home/hadoop/.bash_profile
echo "HADOOP_PREFIX="`echo $INSTALL_DIR`"/hadoop" >> /home/hadoop/.bash_profile
echo "HADOOP_HOME="`echo $INSTALL_DIR`"/hadoop" >> /home/hadoop/.bash_profile
echo "" >> /home/hadoop/.bash_profile
echo "export PS1 HADOOP_PREFIX HADOOP_HOME" >> /home/hadoop/.bash_profile
echo "" >> /home/hadoop/.bash_profile
echo "PATH=\$PATH:\$HADOOP_PREFIX/bin" >> /home/hadoop/.bash_profile
echo "export PATH" >> /home/hadoop/.bash_profile
echo "" >> /home/hadoop/.bash_profile
echo "##############################################################################" >> /home/hadoop/.bash_profile
echo "" >> /home/hadoop/.bash_profile

# ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
# cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys
# ssh localhost

##############################################################################

echo "Creating required directories..."
mkdir -p /data/hadoop
mkdir -p /data/hadoop/mapred/system
mkdir -p /data/hadoop/mapred/local  
mkdir -p /data/hdfs

mkdir -p /var/opt/hadoop/pids
mkdir -p /var/log/hadoop

echo "Setting permissions on directories..."
chown -R hadoop.hadoop /opt/hadoop* 

chown -R hadoop.hadoop /data/hadoop 
chown -R hadoop.hadoop /data/hdfs

chown -R hadoop.hadoop /var/opt/hadoop 
chown -R hadoop.hadoop /var/log/hadoop

##############################################################################

## Disable IPv6 on this system.  If its already disabled then disable_ipv6 returns 1

if [ `cat /proc/sys/net/ipv6/conf/all/disable_ipv6` == 1 ]; then
	echo "IPv6 is already disabled on this host, continuing..."
else
	echo "Disabling IPv6 on this host..."
	echo "" >> /etc/sysctl.conf
	echo "##############################################################################" >> /etc/sysctl.conf
	echo "# Appended by $0 at `date`"  >> /etc/sysctl.conf
	echo "##############################################################################" >> /etc/sysctl.conf
	echo "" >> /etc/sysctl.conf
	echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
	echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
	echo "net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf
	echo "" >> /etc/sysctl.conf

	echo "*** Reboot the system for all the changes to take effect ***"
fi

##############################################################################

echo "End of program"
#
# References:
#
