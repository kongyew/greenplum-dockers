#!/bin/bash
set -e
[[ ${DEBUG} == true ]] && set -x

if [ -f /etc/redhat-release ]; then  # Centos
  major_version=$(rpm -qa \*-release | grep -Ei "oracle|redhat|centos" | cut -d"-" -f3)
elif [ -f /etc/lsb-release ]; then # Ubuntu
  major_version=$(OS_MAJOR_VERSION=`sed -rn 's/.*([0-9])\.[0-9].*/\1/p' /etc/lsb-release`)
fi
## This script assumes startSSH.sh and startInit.sh are executed earlier
if [ -z  "$INSTALL_JUPYTER_CONSOLE" ]; then
  exit 0
fi

if [[ "$INSTALL_JUPYTER_CONSOLE" == "1" || "$INSTALL_JUPYTER_CONSOLE" == 'yes' ]]; then
    "Downloading PIP"
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python get-pip.py
    pip install jupyter-console
else
  exit 0
fi
