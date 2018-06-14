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
while getopts ":hg:" opt; do
  case $opt in
    g)
      echo "Greenplum home is : $OPTARG" >&2
      export GPDB_HOME=$OPTARG
      ;;
    h)
      echo "Help: Please specify greenplum home such as  " >&2
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


if [[ ! "$(whoami)" =~ ^(gpadmin|root)$ ]]
then
    echo "Please run the script as gpadmin or root" >&2
    exit 1
elif [ "$(whoami)" == "gpadmin" ]; then
    gpstop -u
else
    su gpadmin -l -c "gpstop -u"
fi

export GPCC_ZIP=`ls  ./greenplum-cc-web-*-LINUX-x86_64.zip`
unzip ${GPCC_ZIP}

source /usr/local/greenplum-db/greenplum_path.sh

cd greenplum-cc-web-*-LINUX-x86_64
mkdir /usr/local/greenplum-cc-web-4.1.0

export GPCC_BIN=`ls  ./gpccinstall-*`

echo "changeme" | ${GPCC_BIN} -W


gpconfig -s gp_enable_query_metrics
gpconfig -c gp_enable_query_metrics -v on

gpstop -r
