# Java environment installation shell
# @author dkilcy

## If JAVA_HOME is not defined, then define it here...

if [ -z "${JAVA_HOME}" ]; then
   JAVA_HOME="/usr/java/latest"

   ## if JAVA_HOME/bin is not in the PATH, then prepend it...

   if ! echo ${PATH} | /bin/grep -q $JAVA_HOME/bin ; then
      PATH=$JAVA_HOME/bin:${PATH}
   fi

   export JAVA_HOME PATH
fi
