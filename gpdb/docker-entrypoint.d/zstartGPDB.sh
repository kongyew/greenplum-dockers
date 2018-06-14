#!/bin/bash
set -e
[[ ${DEBUG} == true ]] && set -x

if [ -f /etc/redhat-release ]; then  # Centos
  major_version=$(rpm -qa \*-release | grep -Ei "oracle|redhat|centos" | cut -d"-" -f3)
elif [ -f /etc/lsb-release ]; then # Ubuntu
  major_version=$(OS_MAJOR_VERSION=`sed -rn 's/.*([0-9])\.[0-9].*/\1/p' /etc/lsb-release`)
fi
## This script assumes startSSH.sh and startInit.sh are executed earlier
if [ -z  "$START_GPDB" ]; then
  echo "START_GPDB environment variable is not set"
  exit 0
fi

if [[ "$START_GPDB" == "1" || "$START_GPDB" == 'yes' ]]; then
  result=$(ps -ef | grep 'postgres' | wc -l)
  if [[ "$result" -eq "1" ]];then
    echo "greenplum is Not Running"
    /usr/local/bin/startGPDB.sh
  else
    echo "greenplum is Running"
  fi
else
  exit 0
fi
