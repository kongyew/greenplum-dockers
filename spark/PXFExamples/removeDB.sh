#!/bin/bash


set -e

current=`pwd`

cd `dirname $0`

. ./setEnv.sh

cd $current



# Determine greenplum installation
if [ -d "/usr/local/greenplum-db" ]
then
  echo "psql -h ${GREENPLUM_HOST} -U ${GREENPLUM_USER} -d ${GREENPLUM_DB} -c \"DROP DATABASE IF EXISTS ${GREENPLUM_DB}\" "
  psql -h ${GREENPLUM_HOST} -U ${GREENPLUM_USER} -d ${GREENPLUM_DB} -c "DROP TABLE IF EXISTS export"
  psql -h ${GREENPLUM_HOST} -U ${GREENPLUM_USER} -d ${GREENPLUM_DB} -c "DROP DATABASE IF EXISTS ${GREENPLUM_DB}"
else
  echo "aa"
  echo "psql -h ${POSTGRES_HOST} -U ${POSTGRES_USER} -d ${POSTGRES_DB} -c \"DROP DATABASE IF EXISTS ${POSTGRES_DB}\" "
  psql -h ${POSTGRES_HOST} -U ${POSTGRES_USER} -d ${POSTGRES_DB} -c "DROP TABLE IF EXISTS export"
  psql -h ${POSTGRES_HOST} -U ${POSTGRES_USER} -d ${POSTGRES_DB} -c "DROP DATABASE IF EXISTS ${POSTGRES_DB}"
fi
