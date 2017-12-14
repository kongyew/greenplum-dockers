#!/bin/bash
export GPDB_HOSTS=/tmp/gpdb-hosts

[ -f $GPDB_HOSTS ] && echo "seghostfile Found" || echo "seghostfile Not found. Please create this seghostfile with the segment host(s)"

source /usr/local/greenplum-db/greenplum_path.sh
gpssh -e -v -f $GPDB_HOSTS -u gpadmin "/usr/local/greenplum-db/pxf/bin/pxf stop"
