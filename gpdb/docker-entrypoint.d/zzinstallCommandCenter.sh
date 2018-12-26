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

  if [ "$(whoami)" == "gpadmin" ]; then
    sudo chown -R gpadmin:gpadmin /tmp/*.zip
    sudo chown -R gpadmin:gpadmin /opt/gpcc/
    echo "Install GPCC"
    cd /opt/gpcc
    /opt/gpcc/copyGPCCzip.sh
    /opt/gpcc/installDataCollectionAgent.sh
    /opt/gpcc/setupGPCC.sh
    cd $CUR_DIR
  else
    chown -R gpadmin:gpadmin /tmp/*.zip
    chown -R gpadmin:gpadmin /opt/gpcc/
    echo "Install GPCC"
    su gpadmin -c "cd /opt/gpcc"
    su gpadmin -c "/opt/gpcc/copyGPCCzip.sh"
    su gpadmin -c "/opt/gpcc/installDataCollectionAgent.sh"
    su gpadmin -c "/opt/gpcc/setupGPCC.sh"

  fi

else
  exit 0
fi
