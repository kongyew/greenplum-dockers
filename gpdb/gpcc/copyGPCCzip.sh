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

################################################################################
while getopts ":dhg:" opt; do
  case $opt in
    d)
      echo "Location of GPCC zip file is : $OPTARG" >&2
      export GPCC_HOME=$OPTARG
      ;;
    g)
      echo "Greenplum home is : $OPTARG" >&2
      export GPDB_HOME=$OPTARG
      ;;
    h)
      echo "Help: Please specify greenplum home such as  " >&2
      echo "Help: Please specify GPCC home directory such as $1 -d"
      exit 0;
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

if [[ -z "$GPHOME" ]]  # if user specify GPHOME in the env , we will use it.
then
  if [ "$GPHOME" != "" ]
  then
      export GPDB_HOME=$GPHOME
  fi
fi

if [[ -z "$GPCC_HOME" ]]  # if user specify GPCC_HOME in the env , we will use it.
then
  if [ "$GPCC_HOME" != "" ]
  then
      export GPCC_HOME=$GPHOME
  fi
else
   export GPCC_HOME = "/tmp/"
fi

################################################################################
if [[ -z "$GPDB_HOME" ]]
then
    echo "Unable to find environment variable [GPHOME]:$GPDB_HOME "
    exit 1
else

  if [ "$(whoami)" == "gpadmin" ]; then
      source ${GPDB_HOME}/greenplum_path.sh
  else
      export MASTER_DATA_DIRECTORY=/gpdata/master/gpseg-1
  fi

  if [[  -z "${MASTER_DATA_DIRECTORY}" ]]
  then
      echo "Unable to find environment variable [MASTER_DATA_DIRECTORY] :$MASTER_DATA_DIRECTORY"
      exit 1
  fi
  HOSTNAME=`hostname`
  LINE_VALUE="host   all   gpmon   ${HOSTNAME}/32   md5"
  PG_HBA_CONF="${MASTER_DATA_DIRECTORY}/pg_hba.conf"
  SED_VALUE="$a ${LINE_VALUE}"
  #host   all   gpmon   <IP_of_host>/32   md5
  value=$( grep -ic "gpmon" $MASTER_DATA_DIRECTORY/pg_hba.conf )
  if [ $value -eq 1 ]
  then
    echo "Found gpmon in this file : $MASTER_DATA_DIRECTORY/pg_hba.conf"
    #  directly modify the file:
    sed -i '/gpmon/d' $MASTER_DATA_DIRECTORY/pg_hba.conf
    sed -i -e "\$a ${LINE_VALUE}" ${PG_HBA_CONF}
  else
    sed -i -e "\$a ${LINE_VALUE}" ${PG_HBA_CONF}
  fi
fi

if [ "$(whoami)" == "gpadmin" ]; then
    cp  /tmp/greenplum-cc-web-*-LINUX-x86_64.zip /opt/gpcc
    export GPCC_ZIP=`ls  ./greenplum-cc-web-*-LINUX-x86_64.zip`
    unzip ${GPCC_ZIP}
    cp  greenplum-cc-web-*-LINUX-x86_64
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



source /usr/local/greenplum-db/greenplum_path.sh



echo -e "changeme" | ${GPCC_BIN} -W


gpconfig -s gp_enable_query_metrics
gpconfig -c gp_enable_query_metrics -v on

gpstop -r
