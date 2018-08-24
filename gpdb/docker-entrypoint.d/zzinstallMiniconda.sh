#!/bin/bash
set -e
[[ ${DEBUG} == true ]] && set -x

if [ -f /etc/redhat-release ]; then  # Centos
  major_version=$(rpm -qa \*-release | grep -Ei "oracle|redhat|centos" | cut -d"-" -f3)
elif [ -f /etc/lsb-release ]; then # Ubuntu
  major_version=$(OS_MAJOR_VERSION=`sed -rn 's/.*([0-9])\.[0-9].*/\1/p' /etc/lsb-release`)
fi
## This script assumes startSSH.sh and startInit.sh are executed earlier
if [ -z  "$INSTALL_MINICONDA" ]; then
  echo "INSTALL_MINICONDA environment variable is not set"
  exit 0
fi

if [[ "$INSTALL_MINICONDA" == "1" || "$INSTALL_MINICONDA" == 'yes' ]]; then
    wget http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh

    # make the installer executable
    chmod +x miniconda.sh

    # set the installation directory, by default your HOME directory
    INSTALL_DIR=${HOME}

    # run the installer
    ./miniconda.sh -b -p ${INSTALL_DIR}/miniconda

    # add this line in the end of your .bashrc (linux) or .bash_profile (mac)
    export PATH=${INSTALL_DIR}/miniconda/bin:${PATH}

    # update conda (the package and environment manager) to the latest version
    ${INSTALL_DIR}/miniconda/bin/conda update --yes conda

    # install the required packages into
    # $INSTALL_DIR/miniconda/lib/python3.4/site-packages
    # NOTE: this package list might be expanded in the future, so I might
    # want to read if off a "requirements.txt" file ...

    packages=("ipython-notebook"
    "jupyter"
    "scipy"
    "pandas"
    )

    for item in ${packages[*]}
    do
        echo "=====================================================================";
        echo "installing ${item}";
        ${INSTALL_DIR}/miniconda/bin/conda install --yes ${item};
    done

    # install pip
    ${INSTALL_DIR}/miniconda/bin/conda install --yes pip;

    # install palettable
    ${INSTALL_DIR}/miniconda/bin/pip install palettable --proxy http://proxy_url:port
else
  exit 0
fi
