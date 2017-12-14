#/bin/bash
#!/bin/bash
set -e
[[ ${DEBUG} == true ]] && set -x


ROOT_UID=0
export OUTPUTFILE=pxf_hdfs_simple.txt

# Run as root, of course. (this might not be necessary, because we have to run the script somehow with root anyway)
if [ "$UID" -ne "$ROOT_UID" ]
then
  echo 'Prague,Jan,101,4875.33
  Rome,Mar,87,1557.39
  Bangalore,May,317,8936.99
  Beijing,Jul,411,11600.67' > /tmp/$OUTPUTFILE
  chown -R gpadmin:gpadmin /tmp/$OUTPUTFILE

  sudo -u hdfs hadoop fs -mkdir -p /data/pxf_examples
  sudo -u hdfs hadoop fs -put /tmp/$OUTPUTFILE /data/pxf_examples/

else
  echo "Using root to run this script."
  echo 'Prague,Jan,101,4875.33
  Rome,Mar,87,1557.39
  Bangalore,May,317,8936.99
  Beijing,Jul,411,11600.67' > /tmp/$OUTPUTFILE

  sudo -u hdfs hadoop fs -mkdir -p /data/pxf_examples
  sudo -u hdfs hadoop fs -put /tmp/$OUTPUTFILE /data/pxf_examples/
fi
