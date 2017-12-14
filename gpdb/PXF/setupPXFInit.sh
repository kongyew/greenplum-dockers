#!/bin/bash

export GPDB_HOSTS=/tmp/gpdb-hosts


# reference :https://gpdb.docs.pivotal.io/510/pxf/cfginitstart_pxf.html
[ -f GPDB_HOSTS ] && echo "$GPDB_HOSTS Found" || echo "$GPDB_HOSTS Not found."

source /usr/local/greenplum-db/greenplum_path.sh


gpssh -e -v -f $GPDB_HOSTS -u gpadmin "sudo yum -y install unzip"

echo "/usr/local/greenplum-db/pxf/bin/pxf init"
gpssh -e -v -f $GPDB_HOSTS -u gpadmin "/usr/local/greenplum-db/pxf/bin/pxf init "
#"-hadoop-home \$PXF_HADOOP_HOME --hive-home \$PXF_HIVE_HOME"
