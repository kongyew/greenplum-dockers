#!/bin/bash
set -e
[[ ${DEBUG} == true ]] && set -x

if [[ ! "$(whoami)" =~ ^(gpadmin|root)$ ]]
then
    echo "Please run the script as gpadmin or root" >&2
    exit 1
fi

current=`pwd`
. ./util.sh

# Default environment:
if [ -f /usr/local/greenplum-db/greenplum_path.sh ]; then
  export GPDB_HOME="/usr/local/greenplum-db"
fi

if [ -f /opt/gpdb/greenplum_path.sh ]; then
  export GPDB_HOME="/opt/gpdb"
fi


if [ "$(whoami)" == "gpadmin" ]; then
  cp  /tmp/greenplum-cc-web-*-LINUX-x86_64.zip /opt/gpcc
  cd /opt/gpcc
  export GPCC_ZIP=`ls  ./greenplum-cc-web-*-LINUX-x86_64.zip`
  unzip ${GPCC_ZIP}
  export GPCC_BIN=`ls  greenplum-cc-web-*-LINUX-x86_64/gpccinstall-*`
  cp $GPCC_BIN .
  rm -f ${GPCC_ZIP}
  rm -f greenplum-cc-web-*-LINUX-x86_64/*
  rmdir  greenplum-cc-web-*-LINUX-x86_64
  chown -R gpadmin:gpadmin /opt/gpcc/
else
   cp  /tmp/greenplum-cc-web-*-LINUX-x86_64.zip /opt/gpcc
   cd /opt/gpcc
   export GPCC_ZIP=`ls  ./greenplum-cc-web-*-LINUX-x86_64.zip`
   unzip ${GPCC_ZIP}
   export GPCC_BIN=`ls  greenplum-cc-web-*-LINUX-x86_64/gpccinstall-*`
   cp $GPCC_BIN .
   rm -f ${GPCC_ZIP}
   rm -f greenplum-cc-web-*-LINUX-x86_64/*
   rmdir  greenplum-cc-web-*-LINUX-x86_64
   chown -R gpadmin:gpadmin /opt/gpcc/

fi
