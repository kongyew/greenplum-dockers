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
## SLES
CLOUDERA_SLES11_REPO=https://archive.cloudera.com/cdh5/sles/11/x86_64/cdh/cloudera-cdh5.repo
CLOUDERA_SLES12_REPO=https://archive.cloudera.com/cdh5/sles/12/x86_64/cdh/cloudera-cdh5.repo
## UBUNTU  (UBUNTU12, UBUNTU14, UBUNTU16)
# Uses apt-get - see details below


# Default Hadoop client
CLOUDERA_HADOOP_CLIENT_RPM_RHEL5=https://archive.cloudera.com/cdh5/redhat/5/x86_64/cdh/5/RPMS/x86_64/hadoop-client-2.6.0+cdh5.14.0+2715-1.cdh5.14.0.p0.47.el5.x86_64.rpm
CLOUDERA_HADOOP_CLIENT_RPM_RHEL6=https://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/5/RPMS/x86_64/hadoop-client-2.6.0+cdh5.14.0+2715-1.cdh5.14.0.p0.47.el6.x86_64.rpm
CLOUDERA_HADOOP_CLIENT_RPM_RHEL7=https://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/5/RPMS/x86_64/hadoop-client-2.6.0+cdh5.14.0+2715-1.cdh5.14.0.p0.47.el7.x86_64.rpm
## SLES
CLOUDERA_HADOOP_CLIENT_RPM_SLES11=https://archive.cloudera.com/cdh5/sles/11/x86_64/cdh/5.14.2/RPMS/x86_64/hadoop-client-2.6.0+cdh5.14.2+2748-1.cdh5.14.2.p0.11.sles11.x86_64.rpm
CLOUDERA_HADOOP_CLIENT_RPM_SLES12=https://archive.cloudera.com/cdh5/sles/12/x86_64/cdh/5.14.2/RPMS/x86_64/hadoop-client-2.6.0+cdh5.14.2+2748-1.cdh5.14.2.p0.11.sles11.x86_64.rpm

# Default Hbase
CLOUDERA_HBASE_RPM_RHEL5=https://archive.cloudera.com/cdh5/redhat/5/x86_64/cdh/5/RPMS/x86_64/hbase-1.2.0+cdh5.14.0+440-1.cdh5.14.0.p0.47.el5.x86_64.rpm
CLOUDERA_HBASE_RPM_RHEL6=https://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/5/RPMS/x86_64/hbase-1.2.0+cdh5.14.0+440-1.cdh5.14.0.p0.47.el6.x86_64.rpm
CLOUDERA_HBASE_RPM_RHEL7=https://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/5/RPMS/x86_64/hbase-1.2.0+cdh5.14.0+440-1.cdh5.14.0.p0.47.el7.x86_64.rpm
## SLES
CLOUDERA_HBASE_RPM_SLES11=https://archive.cloudera.com/cdh5/sles/11/x86_64/cdh/5.14.2/RPMS/x86_64/hbase-1.2.0+cdh5.14.2+456-1.cdh5.14.2.p0.11.sles11.x86_64.rpm
CLOUDERA_HBASE_RPM_SLES12=https://archive.cloudera.com/cdh5/sles/12/x86_64/cdh/5.14.2/RPMS/x86_64/hbase-1.2.0+cdh5.14.2+456-1.cdh5.14.2.p0.11.sles12.x86_64.rpm

# Default Hive
CLOUDERA_HIVE_RPM_RHEL5=https://archive.cloudera.com/cdh5/redhat/5/x86_64/cdh/5/RPMS/noarch/hive-1.1.0+cdh5.14.0+1330-1.cdh5.14.0.p0.47.el5.noarch.rpm
CLOUDERA_HIVE_RPM_RHEL6=https://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/5/RPMS/noarch/hive-1.1.0+cdh5.14.0+1330-1.cdh5.14.0.p0.47.el6.noarch.rpm
CLOUDERA_HIVE_RPM_RHEL7=https://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/5/RPMS/noarch/hive-1.1.0+cdh5.14.0+1330-1.cdh5.14.0.p0.47.el7.noarch.rpm
## SLES
CLOUDERA_HIVE_RPM_SLES11=https://archive.cloudera.com/cdh5/sles/11/x86_64/cdh/5.14.2/RPMS/noarch/hive-1.1.0+cdh5.14.2+1344-1.cdh5.14.2.p0.11.sles11.noarch.rpm
CLOUDERA_HIVE_RPM_SLES12=https://archive.cloudera.com/cdh5/sles/12/x86_64/cdh/5.14.2/RPMS/noarch/hive-1.1.0+cdh5.14.2+1344-1.cdh5.14.2.p0.11.sles12.noarch.rpm

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
elif [ "$PLATFORM"  == "SLES11" ]; then
  zypper addrepo -f ${CLOUDERA_SLES11_REPO}
  zypper refresh
  # wget ${CLOUDERA_HADOOP_CLIENT_RPM_SLES11} -P ${DOWNLOAD_DIR}
  # wget ${CLOUDERA_HBASE_RPM_SLES11} -P ${DOWNLOAD_DIR}
  # wget ${CLOUDERA_HIVE_RPM_SLES11} -P ${DOWNLOAD_DIR}
# reference : https://www.cloudera.com/documentation/enterprise/latest/topics/cdh_ig_cdh5_install.html
# sudo zypper addrepo -f https://archive.cloudera.com/cdh5/sles/12/x86_64/cdh/cloudera-cdh.repo
# sudo zypper refresh

elif [ "$PLATFORM"  == "SLES12" ]; then
  # wget ${CLOUDERA_HADOOP_CLIENT_RPM_SLES12} -P ${DOWNLOAD_DIR}
  # wget ${CLOUDERA_HBASE_RPM_SLES12} -P ${DOWNLOAD_DIR}
  # wget ${CLOUDERA_HIVE_RPM_SLES12} -P ${DOWNLOAD_DIR}
  zypper addrepo -f ${CLOUDERA_SLES11_REPO}
  zypper refresh
elif [ "$PLATFORM"  == "UBUNTU12" ]; then
  wget 'https://archive.cloudera.com/cdh5/ubuntu/precise/amd64/cdh/cloudera.list' \ -O /etc/apt/sources.list.d/cloudera.list
  apt-get update

elif [ "$PLATFORM"  == "UBUNTU14" ]; then
  wget 'https://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh/cloudera.list' \ -O /etc/apt/sources.list.d/cloudera.list
  apt-get update
elif [ "$PLATFORM"  == "UBUNTU16" ]; then
  wget 'https://archive.cloudera.com/cdh5/ubuntu/xenial/amd64/cdh/cloudera.list' \ -O /etc/apt/sources.list.d/cloudera.list
  apt-get update
else
  echo "Error: Please specify the variable PLATFORM such as RHEL6, UBUNTU14, SLES11"
fi

# wget ${CLOUDERA_HIVE_RPM_RHEL7} -O ${DOWNLOAD_DIR}/hive-1.1.0+cdh5.14.0+1330-1.cdh5.14.0.p0.47.el7.noarch.rpm
# wget ${CLOUDERA_HIVE_RPM_RHEL6} -O ${DOWNLOAD_DIR}/hive-1.1.0+cdh5.14.0+1330-1.cdh5.14.0.p0.47.el7.noarch.rpm

# yum install hadoop-client -y --downloadonly --downloaddir="$DOWNLOADDIR"
