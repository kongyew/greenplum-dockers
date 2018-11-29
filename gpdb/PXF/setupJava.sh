#!/bin/bash
set -e

export GPDB_HOSTS=/tmp/gpdb-hosts
source /usr/local/greenplum-db/greenplum_path.sh

# Change to temporary directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Including files
. "${DIR}"/util.sh

###############################################################################
function InstallJDK_ALLSEGMENTS()
{
  echo "Install Java on each Greenplum Database segment host"
  # Fix this issue "Rpmdb checksum is invalid: dCDPT(pkg checksums)"
  gpssh -e -v -f ${GPDB_HOSTS} -u root rpm --rebuilddb
  gpssh -e -v -f ${GPDB_HOSTS} -u root yum -y update
  #;  yum clean all
  gpssh -e -v -f ${GPDB_HOSTS} -u root yum -y install wget

  gpssh -e -v -f ${GPDB_HOSTS} -u root yum -y install java-1.8.0-openjdk
  # sudo yum install java-1.8.0-openjdk
  # sudo yum install java-1.7.0-openjdk
  # sudo yum install java-1.6.0-openjdk

  echo "Update the gpadmin user’s .bash_profile file on each segment host to include this $JAVA_HOME setting"

  export JRE_HOME=$(pwd /usr/lib/jvm/java-1.8.0-openjdk-*/jre_)

  echo "JRE_HOME : ${JRE_HOME}"
  echo "Add Java home to gpadmin bashrc"
  gpssh -e -v -f ${GPDB_HOSTS} -u gpadmin "echo 'export JAVA_HOME=/usr/lib/jvm/jre-openjdk/' >> /home/gpadmin/.bash_profile"

  #yum clean all \
  #&& rm -rf /var/cache/yum
}
###############################################################################
function InstallJDK()
{
  echo "Install Java on this host"
  # Fix this issue "Rpmdb checksum is invalid: dCDPT(pkg checksums)"
  rpm --rebuilddb
  #;  yum clean all
  yum -y install wget
  yum -y install java-1.8.0-openjdk
  yum clean all
  # sudo yum install java-1.8.0-openjdk
  # sudo yum install java-1.7.0-openjdk
  # sudo yum install java-1.6.0-openjdk

  echo "Update the gpadmin user’s .bash_profile file on each segment host to include this $JAVA_HOME setting"
  export JRE_HOME=$(pwd /usr/lib/jvm/java-1.8.0-openjdk-*/jre_)

  echo "JRE_HOME : ${JRE_HOME}"
  echo "Add Java home to gpadmin bashrc"
  echo 'export JAVA_HOME=/usr/lib/jvm/jre-openjdk/' >> /home/gpadmin/.bash_profile

  #yum clean all \
  #&& rm -rf /var/cache/yum
}

###############################################################################

# Main
startSSH
InstallJDK_ALLSEGMENTS
