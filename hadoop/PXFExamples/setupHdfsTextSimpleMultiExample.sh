#/bin/bash
#!/bin/bash
set -e
[[ ${DEBUG} == true ]] && set -x


ROOT_UID=0

# Run as root, of course. (this might not be necessary, because we have to run the script somehow with root anyway)
if [ "$UID" -ne "$ROOT_UID" ]
then
  echo "Using $UID to run this script."
  rm /tmp/pxf_hdfs_multi.txt
  echo \"4627 Star Rd.San Francisco, CA  94107\":Sept:2017\n\"113 Moon St.San Diego, CA  92093\":Jan:2018\n\"51 Belt Ct.Denver, CO  90123\":Dec:2016\n\"93114 Radial Rd.Chicago, IL  60605\":Jul:2017 > /tmp/pxf_hdfs_multi.txt
  # echo \"113 Moon St.San Diego, CA  92093\":Jan:2018 > /tmp/pxf_hdfs_multi.txt
  #
  # echo \"51 Belt Ct.Denver, CO  90123\":Dec:2016 > /tmp/pxf_hdfs_multi.txt
  # echo \"93114 Radial Rd.Chicago, IL  60605\":Jul:2017 > /tmp/pxf_hdfs_multi.txt
  # echo \"7301 Brookview Ave.Columbus, OH  43213\":Dec:2018 > /tmp/pxf_hdfs_multi.txt
#  echo \"4627 Star Rd.San Francisco, CA  94107\":Sept:2017 > /tmp/pxf_hdfs_multi.txt
  echo \"113 Moon St.San Diego, CA  92093\":Jan:2018 >> /tmp/pxf_hdfs_multi.txt
  echo \"51 Belt Ct.Denver, CO  90123\":Dec:2016 >> /tmp/pxf_hdfs_multi.txt
  echo \"93114 Radial Rd.Chicago, IL  60605\":Jul:2017 >> /tmp/pxf_hdfs_multi.txt
  echo \"7301 Brookview Ave.Columbus, OH  43213\":Dec:2018 >> /tmp/pxf_hdfs_multi.txt

  chown -R gpadmin:gpadmin /tmp/pxf_hdfs_multi.txt
  sudo -u hdfs hadoop fs -mkdir -p /data/pxf_examples
  sudo -u hdfs hadoop fs -put /tmp/pxf_hdfs_multi.txt /data/pxf_examples/

else
  echo "Using root to run this script."

  rm /tmp/pxf_hdfs_multi.txt
  #echo \"4627 Star Rd.San Francisco, CA  94107\":Sept:2017\n\"113 Moon St.San Diego, CA  92093\":Jan:2018\n\"51 Belt Ct.Denver, CO  90123\":Dec:2016\n\"93114 Radial Rd.Chicago, IL  60605\":Jul:2017 > /tmp/pxf_hdfs_multi.txt

  echo -e \"4627 Star Rd.San Francisco, CA  94107\":Sept:2017 > /tmp/pxf_hdfs_multi.txt
  echo  -e \"113 Moon St.San Diego, CA  92093\":Jan:2018 >> /tmp/pxf_hdfs_multi.txt
  echo  -e \"51 Belt Ct.Denver, CO  90123\":Dec:2016 >> /tmp/pxf_hdfs_multi.txt
  echo  -e \"93114 Radial Rd.Chicago, IL  60605\":Jul:2017 >> /tmp/pxf_hdfs_multi.txt
  echo  -e \"7301 Brookview Ave.Columbus, OH  43213\":Dec:2018 >> /tmp/pxf_hdfs_multi.txt

  chown -R gpadmin:gpadmin /tmp/pxf_hdfs_multi.txt
  sudo -u hdfs hadoop fs -mkdir -p /data/pxf_examples
  sudo -u hdfs hadoop fs -rm /data/pxf_examples/pxf_hdfs_multi.txt
  sudo -u hdfs hadoop fs -put /tmp/pxf_hdfs_multi.txt /data/pxf_examples/
  sudo -u hdfs hadoop fs -ls  /data/pxf_examples/pxf_hdfs_multi.txt
fi
