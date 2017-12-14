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
# http://mirrors.ocf.berkeley.edu/apache/hadoop/common/hadoop-2.6.5/hadoop-2.6.5.tar.gz
echo "export HADOOP_USER_NAME=gpadmin"
gpssh -e -v -f ${GPDB_HOSTS} -u gpadmin "echo 'export HADOOP_USER_NAME=gpadmin' >> /home/gpadmin/.bash_profile"

echo "export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin"
gpssh -e -v -f ${GPDB_HOSTS} -u gpadmin "echo 'export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin' >> /home/gpadmin/.bash_profile"

# Reference: https://gpdb.docs.pivotal.io/530/admin_guide/external/g-one-time-hdfs-protocol-installation.html
gpssh -e -v -f ${GPDB_HOSTS} -u gpadmin "gpconfig -c gp_hadoop_target_version -v 'hdb2'"
