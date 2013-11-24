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
# Install optional packages
#
# Tested on CentOS 6.4
#
#

if [ $USER != "root" ]; then echo "Must be run as root, aborting."; exit -1; fi 

echo "Start of program"

cd /data/software

##wget http://pkgs.repoforge.org/lshw/lshw-2.15-1.el6.rf.x86_64.rpm
##rpm -ivh lshw-2.15-1.el6.rf.x86_64.rpm 

yum install gcalctool

echo "End of program"
#
# References:
#
