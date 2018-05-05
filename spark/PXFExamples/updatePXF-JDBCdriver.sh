#!/bin/bash
set -e
[[ ${DEBUG} == true ]] && set -x

set -x

PWD=`pwd`
JDBC_JAR=$(ls $PWD/postgresql*.jar)
PXFPUBLIC_FILE="/usr/local/greenplum-db/pxf/conf/pxf-public.classpath"

if grep -Fxq "${JDBC_JAR}" $PXFPUBLIC_FILE
then
  if [ -d "/usr/local/greenplum-db" ]
  then
    echo "Found /usr/local/greenplum-db"
    sed -i 's/*postgresql*[0-9].jar/$JDBC_JAR/g' $PXFPUBLIC_FILE
  else
    echo " /usr/local/greenplum-db directory does NOT exists"
    exit 1
  fi
else
  if [ -d "/usr/local/greenplum-db" ]
  then
    echo "Found /usr/local/greenplum-db"
    sed -i "$ a\ ${JDBC_JAR}" $PXFPUBLIC_FILE 
    /usr/local/greenplum-db/pxf/bin/pxf stop
    /usr/local/greenplum-db/pxf/bin/pxf start
  else
    echo " /usr/local/greenplum-db directory does NOT exists"
    exit 1
  fi
fi
