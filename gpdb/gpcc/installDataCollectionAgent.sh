#!/bin/bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Including configurations

. "${DIR}"/config.sh

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


source /usr/local/greenplum-db/greenplum_path.sh
export GPCC_DIR=`ls gpccinstall-*`
export GPCC_BIN="./$GPCC_DIR "
export MASTER_DATA_DIRECTORY=/gpdata/master/gpseg-1

if [ "$(whoami)" == "gpadmin" ]; then
  echo "Install GPPerMon"
  gpperfmon_install --enable --password changeme --port 5432
  gpstop -ar
  echo -e "changeme" | sudo ${GPCC_BIN} -W
  gpconfig -s gp_enable_query_metrics
  gpconfig -c gp_enable_query_metrics -v on
  gpstop -ar
  ps -ef | grep gpmmon | wc -l
  psql gpperfmon -c 'SELECT * FROM system_now;'
else
  echo "Install GPPerMon"
  su gpadmin -c "gpperfmon_install --enable --password changeme --port 5432"
  su gpadmin -c "gpstop -ar"
  su gpadmin -c "echo -e \"changeme\" | sudo ${GPCC_BIN} -W"
  su gpadmin -c "gpconfig -s gp_enable_query_metrics"
  su gpadmin -c "gpconfig -c gp_enable_query_metrics -v on"
  su gpadmin -c "gpstop -ar"
  su gpadmin -c "ps -ef | grep gpmmon | wc -l "
  psql gpperfmon -c 'SELECT * FROM system_now;'
fi
