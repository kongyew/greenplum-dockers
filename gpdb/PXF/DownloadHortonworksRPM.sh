#!/bin/bash
set -e

DOWNLOAD_DIR="./HORTONWORKS"
PLATFORM="RHEL6"  # RHEL5, RHEL6, RHEL7

if [ -d $DOWNLOAD_DIR ]; then
  echo "Using $DOWNLOAD_DIR"
else
  mkdir "$DOWNLOAD_DIR"
fi
###############################################################################
# Default Hortonworks 2.6 Repository

HORTONWORKS_RHEL6_REPO=http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.6.0.3/hdp.repo
HORTONWORKS_RHEL7_REPO=http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.6.0.3/hdp.repo
HORTONWORKS_SLES11_REPO=http://public-repo-1.hortonworks.com/HDP/suse11sp3/2.x/updates/2.6.0.3/hdp.repo
HORTONWORKS_SLES12_REPO=http://public-repo-1.hortonworks.com/HDP/sles12/2.x/updates/2.6.0.3/hdp.repo
HORTONWORKS_UBUNTU14_REPO=http://public-repo-1.hortonworks.com/HDP/ubuntu14/2.x/updates/2.6.0.3/hdp.list
HORTONWORKS_UBUNTU16_REPO=http://public-repo-1.hortonworks.com/HDP/ubuntu16/2.x/updates/2.6.0.3/hdp.list




wget http://public-repo-1.hortonworks.com/HDP/ubuntu<version>/2.x/updates/2.6.3.0/hdp.list -O /etc/apt/sources.list.d/hdp.list
wget http://public-repo-1.hortonworks.com/HDP/debian<version>/2.x/updates/2.6.3.0/hdp.list -O /etc/apt/sources.list.d/hdp.list



if [ "$PLATFORM" == "RHEL6" ]; then
  wget -nv $HORTONWORKS_RHEL6_REPO -O /etc/yum.repos.d/hdp.repo
  #
elif [ "$PLATFORM"  == "RHEL7" ]; then
  wget -nv $HORTONWORKS_RHEL7_REPO -O /etc/yum.repos.d/hdp.repo
   #
elif [ "$PLATFORM"  == "SLES11" ]; then

else
  echo "Error: Please specify the variable PLATFORM"
fi
