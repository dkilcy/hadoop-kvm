#!/bin/bash
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
