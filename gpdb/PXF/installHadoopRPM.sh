#!/bin/bash
set -e

export GPDB_HOSTS=/tmp/gpdb-hosts
source /usr/local/greenplum-db/greenplum_path.sh

echo "**** Checking Packages ****"
yum clean all
yum update
array=(hadoop-client hive hbase)
for pkg in "${array[@]}"
do
pkg="$pkg"
    # grep -ir $pkg /var/cache/yum/ > /dev/null
    yum list $pkg > /dev/null
    # yum search $pkg>/dev/null
    a=$?
    echo "- $? - $a -"
    if [ $a -eq 0 ]
            then
                    echo "* $pkg * installed or available to be installed"
                    # yum install $pkg
            else
                    echo "* $pkg not found or unknown error."
    fi
done
