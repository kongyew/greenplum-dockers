#!/bin/bash
set -e
[[ ${DEBUG} == true ]] && set -x

if [ -f /etc/redhat-release ]; then  # Centos
  major_version=$(rpm -qa \*-release | grep -Ei "oracle|redhat|centos" | cut -d"-" -f3)
elif [ -f /etc/lsb-release ]; then # Ubuntu
  major_version=$(OS_MAJOR_VERSION=`sed -rn 's/.*([0-9])\.[0-9].*/\1/p' /etc/lsb-release`)
fi
## This script assumes startSSH.sh and startInit.sh are executed earlier
if [ -z  "$START_PXF" ]; then
  exit 0
fi

if [[ "$START_PXF" == "1" || "$START_PXF" == 'yes' ]]; then
  result=$(ps -ef | grep 'pxf' | wc -l)
  if [[ "$result" -eq "1" ]];then
    echo "pxf is Not Running"
    /usr/local/bin/startPXF.sh
  else
    echo "pxf is Running"
  fi
else
  exit 0
fi
