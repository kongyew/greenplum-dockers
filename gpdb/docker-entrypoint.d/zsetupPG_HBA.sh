#!/bin/bash
set -e
[[ ${DEBUG} == true ]] && set -x

if [ -f /etc/redhat-release ]; then  # Centos
  major_version=$(rpm -qa \*-release | grep -Ei "oracle|redhat|centos" | cut -d"-" -f3)
elif [ -f /etc/lsb-release ]; then # Ubuntu
  major_version=$(OS_MAJOR_VERSION=`sed -rn 's/.*([0-9])\.[0-9].*/\1/p' /etc/lsb-release`)
fi
## This script assumes startSSH.sh and startInit.sh are executed earlier
if [ -z  "$SETUP_PG_HBA" ]; then
  exit 0
fi


# Determine greenplum installation
if [ -d "/usr/local/greenplum-db" ]
then
  export GPDB_DIR="/usr/local/greenplum-db"
else
  if [ -d "/opt/gpdb" ]
  then
    export GPDB_DIR="/usr/local/greenplum-db"
  else
      echo "Directory /opt/gpdb does not exists."
  fi
fi
export GPDB_PG_HBA_CONF="/gpdata/master/gpseg-1/pg_hba.conf"
# Determine greenplum data - pg_hba.conf
if [ -f "/gpdata/master/gpseg-1/pg_hba.conf" ]
then
  export GPDB_PG_HBA_CONF="/gpdata/master/gpseg-1/pg_hba.conf"
else
  if [ -f "/opt/gpdb/master/gpseg-1/pg_hba.conf" ]
  then
    export GPDB_PG_HBA_CONF="/opt/gpdb/master/gpseg-1/pg_hba.conf"
  else
      echo "pg_hba.conf does not exists."
  fi
fi

cd $current


if [[ "$SETUP_PG_HBA" != "" ]]; then
  echo "host    all             all              0.0.0.0/0                  md5" >> $GPDB_PG_HBA_CONF
  echo "host    all             all              ::/0                       md5" >> $GPDB_PG_HBA_CONF

  result=$(ps -ef | grep 'postgres' | wc -l)
  if [[ "$result" -eq "1" ]];then
    echo "Postgres is Not Running"
  else
    echo "Postgres is Running"
    /usr/local/bin/stopGPDB.sh
  fi
  /usr/local/bin/startGPDB.sh
else
  exit 0
fi
