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
# Java environment installation shell
# Sets JAVA_HOME and prepends to PATH
#
# Copy to /etc/profile.d as root user
#
# Tested on CentOS 6.4
#

## If JAVA_HOME is not defined, then define it here...

if [ -z "${JAVA_HOME}" ]; then
   JAVA_HOME="/usr/java/latest"

   ## if JAVA_HOME/bin is not in the PATH, then prepend it...

   if ! echo ${PATH} | /bin/grep -q $JAVA_HOME/bin ; then
      PATH=$JAVA_HOME/bin:${PATH}
   fi

   export JAVA_HOME PATH
fi

