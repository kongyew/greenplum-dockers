#!/bin/bash
# Purpose : configure Cloudera, Hortonworks , in order to use Greenplum PXF
set -e

export GPDB_HOSTS=/tmp/gpdb-hosts
source /usr/local/greenplum-db/greenplum_path.sh

export CLOUDERA_HIVE_DOWNLOAD_URL=http://archive.cloudera.com/cdh5/cdh/5/hive-1.1.0-cdh5.10.2.tar.gz
export CLOUDERA_HIVE_TAR_GZ=hive-1.1.0-cdh5.10.2.tar.gz
export CLOUDERA_HIVE_DIR=hive-1.1.0-cdh5.10.2

# Change to temporary directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Including files
. ${DIR}/util.sh

###############################################################################
function InstallCDHHive_TAR_GZ()
{
  echo "Download Cloudera 2.6-cdh5 - HIVE from $CLOUDERA_HIVE_DOWNLOAD_URL"
  wget $CLOUDERA_HIVE_DOWNLOAD_URL -O /tmp/$CLOUDERA_HIVE_TAR_GZ

  echo "Copy Cloudera 2.6 Hive to all segments"
  gpscp -v -f ${GPDB_HOSTS}  /tmp/$CLOUDERA_HIVE_TAR_GZ =:/home/gpadmin
  echo "Extract Cloudera 2.6 Hive to all segments"
  gpssh -e -v -f ${GPDB_HOSTS} -u gpadmin "tar zxf /home/gpadmin/$CLOUDERA_HIVE_TAR_GZ"

  echo "chmod -R 755 /home/gpadmin/$CLOUDERA_HIVE_DIR"
  gpssh -e -v -f ${GPDB_HOSTS} -u gpadmin "chmod -R 755 /home/gpadmin/$CLOUDERA_HIVE_DIR"

  echo "export PXF_HIVE_HOME=/home/gpadmin/$CLOUDERA_HIVE_DIR"
  gpssh -e -v -f ${GPDB_HOSTS} -u gpadmin "echo 'export PXF_HIVE_HOME=/home/gpadmin/$CLOUDERA_HIVE_DIR' >> /home/gpadmin/.bash_profile"

  echo "rm /home/gpadmin/$CLOUDERA_HIVE_TAR_GZ "
  gpssh -e -v -f ${GPDB_HOSTS} -u gpadmin "rm /home/gpadmin/$CLOUDERA_HIVE_TAR_GZ"
}
###############################################################################
function InstallCDHHive_RPM()
{
  echo "Run 'sudo yum -y install hive' on all segments"
  gpssh -e -v -f ${GPDB_HOSTS} -u gpadmin "sudo yum -y install hive"

  echo "Run 'sudo yum -y install hbase' on all segments"
  gpssh -e -v -f ${GPDB_HOSTS} -u gpadmin "sudo yum -y install hbase"
}
###############################################################################

###############################################################################
# Main
#InstallCDHHive_TAR_GZ
InstallCDHHive_RPM
