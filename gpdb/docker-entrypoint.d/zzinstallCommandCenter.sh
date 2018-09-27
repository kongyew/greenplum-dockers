#!/bin/bash
set -e
[[ ${DEBUG} == true ]] && set -x

if [ -f /etc/redhat-release ]; then  # Centos
  major_version=$(rpm -qa \*-release | grep -Ei "oracle|redhat|centos" | cut -d"-" -f3)
elif [ -f /etc/lsb-release ]; then # Ubuntu
  major_version=$(OS_MAJOR_VERSION=`sed -rn 's/.*([0-9])\.[0-9].*/\1/p' /etc/lsb-release`)
fi
## This script assumes startSSH.sh and startInit.sh are executed earlier
if [ -z  "$INSTALL_COMMANDCENTER" ]; then
  echo "INSTALL_COMMANDCENTER environment variable is not set"
  exit 0
fi
# set curr
CUR_DIR=`pwd`


if [[ "$INSTALL_COMMANDCENTER" == "1" || "$INSTALL_COMMANDCENTER" == 'yes' ]]; then
    cd /opt/gpcc
    /opt/gpcc/setupGPCC.sh
    cd $CUR_DIR
else
  exit 0
fi
