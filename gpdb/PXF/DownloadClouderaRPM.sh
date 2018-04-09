#!/bin/bash
set -e

DOWNLOAD_DIR="./CLOUDERA"
PLATFORM="RHEL6"  # RHEL5, RHEL6, RHEL7

if [ -d $DOWNLOAD_DIR ]; then
  echo "Using $DOWNLOAD_DIR"
else
  mkdir "$DOWNLOAD_DIR"
fi
###############################################################################
# Default Cloudera Repository
CLOUDERA_RHEL5_REPO=https://archive.cloudera.com/cdh5/redhat/5/x86_64/cdh/cloudera-cdh5.repo
CLOUDERA_RHEL6_REPO=https://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/cloudera-cdh5.repo
CLOUDERA_RHEL7_REPO=https://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/cloudera-cdh5.repo

# Default Hadoop client
CLOUDERA_HADOOP_CLIENT_RPM_RHEL5=https://archive.cloudera.com/cdh5/redhat/5/x86_64/cdh/5/RPMS/x86_64/hadoop-client-2.6.0+cdh5.14.0+2715-1.cdh5.14.0.p0.47.el5.x86_64.rpm
CLOUDERA_HADOOP_CLIENT_RPM_RHEL6=https://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/5/RPMS/x86_64/hadoop-client-2.6.0+cdh5.14.0+2715-1.cdh5.14.0.p0.47.el6.x86_64.rpm
CLOUDERA_HADOOP_CLIENT_RPM_RHEL7=https://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/5/RPMS/x86_64/hadoop-client-2.6.0+cdh5.14.0+2715-1.cdh5.14.0.p0.47.el7.x86_64.rpm

# Default Hbase
CLOUDERA_HBASE_RPM_RHEL5=https://archive.cloudera.com/cdh5/redhat/5/x86_64/cdh/5/RPMS/x86_64/hbase-1.2.0+cdh5.14.0+440-1.cdh5.14.0.p0.47.el5.x86_64.rpm
CLOUDERA_HBASE_RPM_RHEL6=https://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/5/RPMS/x86_64/hbase-1.2.0+cdh5.14.0+440-1.cdh5.14.0.p0.47.el6.x86_64.rpm
CLOUDERA_HBASE_RPM_RHEL7=https://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/5/RPMS/x86_64/hbase-1.2.0+cdh5.14.0+440-1.cdh5.14.0.p0.47.el7.x86_64.rpm

# Default Hive
CLOUDERA_HIVE_RPM_RHEL5=https://archive.cloudera.com/cdh5/redhat/5/x86_64/cdh/5/RPMS/noarch/hive-1.1.0+cdh5.14.0+1330-1.cdh5.14.0.p0.47.el5.noarch.rpm
CLOUDERA_HIVE_RPM_RHEL6=https://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/5/RPMS/noarch/hive-1.1.0+cdh5.14.0+1330-1.cdh5.14.0.p0.47.el6.noarch.rpm
CLOUDERA_HIVE_RPM_RHEL7=https://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/5/RPMS/noarch/hive-1.1.0+cdh5.14.0+1330-1.cdh5.14.0.p0.47.el7.noarch.rpm

if [ "$PLATFORM" == "RHEL5" ]; then
  wget ${CLOUDERA_HADOOP_CLIENT_RPM_RHEL5} -P ${DOWNLOAD_DIR}
  wget ${CLOUDERA_HBASE_RPM_RHEL5} -P ${DOWNLOAD_DIR}
  wget ${CLOUDERA_HIVE_RPM_RHEL5} -P ${DOWNLOAD_DIR}
  #
 elif [ "$PLATFORM"  == "RHEL6" ]; then
   wget ${CLOUDERA_HADOOP_CLIENT_RPM_RHEL6} -P ${DOWNLOAD_DIR}
   wget ${CLOUDERA_HBASE_RPM_RHEL6} -P ${DOWNLOAD_DIR}
   wget ${CLOUDERA_HIVE_RPM_RHEL6} -P ${DOWNLOAD_DIR}
   #
elif [ "$PLATFORM"  == "RHEL7" ]; then
  wget ${CLOUDERA_HADOOP_CLIENT_RPM_RHEL7} -P ${DOWNLOAD_DIR}
  wget ${CLOUDERA_HBASE_RPM_RHEL7} -P ${DOWNLOAD_DIR}
  wget ${CLOUDERA_HIVE_RPM_RHEL7} -P ${DOWNLOAD_DIR}
else
  echo "Error: Please specify the variable PLATFORM"
fi

# wget ${CLOUDERA_HIVE_RPM_RHEL7} -O ${DOWNLOAD_DIR}/hive-1.1.0+cdh5.14.0+1330-1.cdh5.14.0.p0.47.el7.noarch.rpm
# wget ${CLOUDERA_HIVE_RPM_RHEL6} -O ${DOWNLOAD_DIR}/hive-1.1.0+cdh5.14.0+1330-1.cdh5.14.0.p0.47.el7.noarch.rpm

# yum install hadoop-client -y --downloadonly --downloaddir="$DOWNLOADDIR"
