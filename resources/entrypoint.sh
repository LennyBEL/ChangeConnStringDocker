#!/bin/bash


# ENVIRONMENT VARIABLES
# $SSHUSER = SSH user for remote
# $SSHPASS = SSH password for remote
# $NEWCONNSTRING = the new connection string
# $HOSTIP = IP Address of host

# Because the connection string tends to contain characters like "/", we need to add escape these characters.
# We can do this with sed. The script below will add an escape character "\" to certain characters.
ESCAPED="$(echo ${NEWCONNSTRING} | sed -e 's/[\/&]/\\&/g')"

# remote_script.sh is the script we'll execute on the host device.
# In this script, we have a placeholder for the connection string. Below we're going to replace that placeholder with the new connection string.
sed -i "s/CONNSTRING_PLACEHOLDER/${ESCAPED}/g" /data/resources/remote_script.sh

# Last step is to use sshpass to SSH into the host with a password.
# Then we're going to enable sudo by passing the password and then sudo execute the script.
sshpass -p$SSHPASS ssh -o StrictHostKeyChecking=no $SSHUSER@$HOSTIP "echo ${SSHPASS} | sudo -Sv && bash -s" < /data/resources/remote_script.sh