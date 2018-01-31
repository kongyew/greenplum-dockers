#/bin/bash
#!/bin/bash
set -e
[[ ${DEBUG} == true ]] && set -x


ROOT_UID=0
export OUTPUTFILE=pxf_hive_datafile.txt

# Run as root, of course. (this might not be necessary, because we have to run the script somehow with root anyway)
if [ "$UID" -ne "$ROOT_UID" ]
then
  echo "Using $UID to run this script."
  rm /tmp/$OUTPUTFILE

  chown -R gpadmin:gpadmin /tmp/$OUTPUTFILE
  sudo -u hdfs hadoop fs -mkdir -p /data/pxf_examples
  sudo -u hdfs hadoop fs -put /tmp/$OUTPUTFILE /data/pxf_examples/

else
  echo "Using root to run this script."

  rm /tmp/$OUTPUTFILE
  echo -e Prague,Jan,101,4875.33 > /tmp/$OUTPUTFILE
  echo  -e "Prague,Jan,101,4875.33" >> /tmp/$OUTPUTFILE
  echo  -e "Rome,Mar,87,1557.39" >> /tmp/$OUTPUTFILE
  echo  -e "Bangalore,May,317,8936.99" >> /tmp/$OUTPUTFILE
  echo  -e "Beijing,Jul,411,11600.67" >> /tmp/$OUTPUTFILE
  echo  -e "San Francisco,Sept,156,6846.34" >> /tmp/$OUTPUTFILE
  echo  -e "Prague,Dec,333,9894.77" >> /tmp/$OUTPUTFILE
  echo  -e "Bangalore,Jul,271,8320.55" >> /tmp/$OUTPUTFILE
  echo  -e "Beijing,Dec,100,4248.41" >> /tmp/$OUTPUTFILE

  chown -R gpadmin:gpadmin /tmp/$OUTPUTFILE
  sudo -u hdfs hadoop fs -mkdir -p /data/pxf_examples
  sudo -u hdfs hadoop fs -put /tmp/$OUTPUTFILE /data/pxf_examples/
fi
