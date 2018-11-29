#!/bin/bash
set -e
[[ ${DEBUG} == true ]] && set -x

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Including files
. ${DIR}/util.sh

startSSH

# Default environment:
if [ -f /usr/local/greenplum-db/greenplum_path.sh ]; then
  export GPDB_HOME="/usr/local/greenplum-db"
fi

if [ -f /opt/gpdb/greenplum-db/greenplum_path.sh ]; then
  export GPDB_HOME="/opt/gpdb"
fi


export MASTER_DATA_DIRECTORY=/gpdata/master/gpseg-1
export GPDB_HOSTS=/tmp/gpdb-hosts

################################################################################
echo "Create $MASTER_DATA_DIRECTORY/gpssh.conf;"
echo "[gpssh]" >> $MASTER_DATA_DIRECTORY/gpssh.conf
echo "delaybeforesend = 0.05" >>  $MASTER_DATA_DIRECTORY/gpssh.conf
echo "prompt_validation_timeout = 1.0" >> $MASTER_DATA_DIRECTORY/gpssh.conf
echo "sync_retries = 5" >> $MASTER_DATA_DIRECTORY/gpssh.conf
echo "Using scripts to download tar files or RPM"

echo "Install Java JDK"
su gpadmin -c "setupJava.sh RPM"

su gpadmin -c "setupPXFInit.sh"
