#!/bin/bash
set -e


check_stat=`ps -ef | grep '[s]shd' | awk '{print $2}'`
if [ -n "$check_stat" ]
then
   echo "SSHD is running"

else
   echo "SSHD isn't running"
   service sshd start
fi
export MASTER_DATA_DIRECTORY=/gpdata/master/gpseg-1
export GPDB_HOSTS=/tmp/gpdb-hosts

#
echo "Create $MASTER_DATA_DIRECTORY/gpssh.conf;"
echo "[gpssh]" >> $MASTER_DATA_DIRECTORY/gpssh.conf
echo "delaybeforesend = 0.05" >>  $MASTER_DATA_DIRECTORY/gpssh.conf
echo "prompt_validation_timeout = 1.0" >> $MASTER_DATA_DIRECTORY/gpssh.conf
echo "sync_retries = 5" >> $MASTER_DATA_DIRECTORY/gpssh.conf


echo "Using scripts to download tar files or RPM"
su gpadmin -c "setupPXFHadoop.sh RPM"
service sshd restart # sometime it failed
su gpadmin -c "setupPXFHive.sh RPM"
su gpadmin -c "setupPXFInit.sh"
