#!/bin/bash

set -e

current=`pwd`

cd `dirname $0`

. ./setEnv.sh

# drop existing database
#psql -h ${GREENPLUM_HOST} -U ${GREENPLUM_USER} -d ${GREENPLUM_DB} -c "DROP DATABASE IF EXISTS  ${GREENPLUM_DB}"
createdb -h ${GREENPLUM_HOST} -U ${GREENPLUM_USER} ${GREENPLUM_DB}

echo "psql -d [mytestdb]   -f $GPHOME/share/postgresql/pljava/install.sql"
psql -h ${GREENPLUM_HOST} -U ${GREENPLUM_USER} -d ${GREENPLUM_DB} -f  $GPHOME/share/postgresql/pljava/install.sql


cd $current
