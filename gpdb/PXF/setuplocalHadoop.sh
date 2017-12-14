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

export GPDB_HOSTS=/tmp/gpdb-hosts

source /usr/local/greenplum-db/greenplum_path.sh
export MASTER_DATA_DIRECTORY=/data/master/gpseg-1

cat > /tmp/example.txt  <<'EOT'
line1, line1a
line2, line2a
line3, line3a
EOT


su gpadmin -c "setupPXFHadoop.sh"
su gpadmin -c "setupPXFHive.sh"
su gpadmin -c "setupPXFInit.sh"

sudo addgroup hadoop
sudo adduser --ingroup hadoop hduser
su - hduser
ssh-keygen -t rsa -P ""


mkdir /usr/local/hdfs
cd /usr/local/hdfs
tar -xzf /hadoop-2.7.3.tar.gz

cd /usr/local/hdfs/hadoop-2.7.3
