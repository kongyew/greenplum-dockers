#!/bin/bash -x
echo "Downloading JDBC for Postgres"
curl -o postgresql-42.2.2.jar https://jdbc.postgresql.org/download/postgresql-42.2.2.jar

PWD=`pwd`
JDBC_JAR=$(ls $PWD/postgresql*.jar)
PXFPUBLIC_FILE="/usr/local/greenplum-db/pxf/conf/pxf-public.classpath"



if [ -d "/usr/local/gpdb" ]
then
  echo "Found /usr/local/gpdb"
else
  if [ -d "/usr/local/greenplum-db" ]
  then
    echo "Found /usr/local/greenplum-db"

    sed -i 's/*postgresql*[0-9].jar/#JDBC_JAR/g' $PXFPUBLIC_FILE
  else
    echo " /usr/local/greenplum-db directory does NOT exists"

  fi
fi
