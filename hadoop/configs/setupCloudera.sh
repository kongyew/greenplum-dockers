#!/bin/bash
check_stat=`ps -ef | grep 'hadoop' | awk '{print $2}'`
if [ -n "$check_stat" ]
then
   echo "Apache Hadoop is running"

else
   echo "Apache Hadoop isn't running"
 # TBD
fi


export CORE_SITE_XML=../conf/core-site.xml
export HDFS_SITE_XML=../conf/hdfs-site.xml
export MAPRED_SITE_XML=../conf/mapred-site.xml
export START_PXF="/usr/local/bin/startPXF.sh"
export STOP_PXF="/usr/local/bin/stopPXF.sh"


if [ -f $CORE_SITE_XML ]
then
   echo "cp $CORE_SITE_XML /etc/hadoop/conf/core-site.xml"
   sudo cp $CORE_SITE_XML /etc/hadoop/conf/core-site.xml
else
   echo "$CORE_SITE_XML is not found"
 # TBD
fi

if [ -f $HDFS_SITE_XML ]
then
   echo "cp $HDFS_SITE_XML /etc/hadoop/conf/hdfs-site.xml"
   sudo cp $HDFS_SITE_XML /etc/hadoop/conf/hdfs-site.xml
else
   echo "$HDFS_SITE_XML is not found"
 # TBD
fi

if [ -f $MAPRED_SITE_XML ]
then
   echo "cp $MAPRED_SITE_XML /etc/hadoop/conf/mapred-site.xml"
   sudo cp $MAPRED_SITE_XML /etc/hadoop/conf/mapred-site.xml
else
   echo "$MAPRED_SITE_XML is not found"
 # TBD
fi

$STOP_PXF
$START_PXF
