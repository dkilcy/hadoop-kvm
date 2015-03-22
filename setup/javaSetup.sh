#!/bin/bash
#
# @author dkilcy
#
# Remove OpenJDK and install Oracle JDK 7
#
# Tested on CentOS 6.4
#
# Prerequesites:
# Oracle JDK in /data/software
#

if [ $USER != "root" ]; then echo "Must be run as root, aborting."; exit -1; fi

echo "Start or program"

CURR_PWD=$PWD
echo "Current directory is $CURR_PWD"

## Below no longer works, Oracle requires agreeing to license terms before download
### cd /data/software
### wget http://download.oracle.com/otn-pub/java/jdk/7u45-b18/jdk-7u45-linux-x64.rpm 
#

for SW in /data/software/jdk-7u45-linux-x64.rpm 
do
   if ! [ -f $SW ]; then echo "Missing $SW, aborting"; exit -1; fi
done
 
#
echo "Removing OpenJDK..."

yum remove java-1.6.0-openjdk java-1.7.0-openjdk

echo "Verifying no java on PATH"
which java
update-alternatives --config java

#
echo "Install Sun JDK 1.7..."

rpm -Uvh /data/software/jdk-7u45-linux-x64.rpm
 
#
echo "Copying java.sh to /etc/profile.d"

cd $CURR_PWD
cp java.sh /etc/profile.d/
chmod 644 /etc/profile.d/java.sh

echo "End of script"
#
# References:
# http://www.admon.org/difference-between-login-shell-and-non-login-shell/
#
