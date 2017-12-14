wget https://downloads-hortonworks.akamaized.net/sandbox-hdp-2.6.1/HDP_2_6_1_docker_image_28_07_2017_14_42_40.tar


docker load -i <sandbox-docker-image-path>


s://downloads.cloudera.com/demo_vm/docker/cloudera-quickstart-vm-5.12.0-0-beta-docker.tar.gz

# https://www.cloudera.com/downloads/quickstart_vms/5-12.html


username: cloudera
password: cloudera
SHA1 for Docker image: 4b9c757d2a9823ca580a455dd32908a0747604d3


docker run --hostname=quickstart.cloudera --privileged=true -t -i cloudera/quickstart:latest /usr/bin/docker-quickstart



sudo groupadd gpadmin
sudo useradd gpadmin -g gpadmin
sudo passwd gpadmin
<give a simple password for this login in Cloudera Quickstart VM)
Now create a HDFS home directory for this gpadmin user

hadoop dfsadmin -safemode leave


sudo -u hdfs hadoop fs -mkdir -p /user/gpadmin
sudo -u hdfs hadoop fs -chmod -R 755 /user/gpadmin
sudo -u hdfs hadoop fs -chown -R gpadmin:gpadmin /user/gpadmin

echo 'Prague,Jan,101,4875.33
Rome,Mar,87,1557.39
Bangalore,May,317,8936.99
Beijing,Jul,411,11600.67' > /tmp/pxf_hdfs_simple.txt


[cloudera@quickstart /]$ sudo -u hdfs hadoop fs -mkdir -p /data/pxf_examples
[cloudera@quickstart /]$ sudo -u hdfs hadoop fs -put /tmp/pxf_hdfs_simple.txt /data/pxf_examples/



git clone https://github.com/hortonworks/hive-testbench


su cloudera
[cloudera@quickstart hive-testbench]$ sudo mkdir -p /usr/lib/tpcds
[cloudera@quickstart hive-testbench]$ sudo chmod -R 777 /usr/lib/tpcds
[cloudera@quickstart hive-testbench]$ cd usr/lib/tpcds
bash: cd: usr/lib/tpcds: No such file or directory
[cloudera@quickstart hive-testbench]$ cd /usr/lib/tpcds


wget https://github.com/hortonworks/hive-testbench/archive/hive14.zip
This indicates the Cloudera Manager startup runs into an error. What you should do is to check the log file of your Cloudera Manager, which should be located at /var/log/cloudera-scm-server directory. Since this is a POC cluster, I assume that when you set it up, you did not use the external database like MySQL. Instead, you probably used the embedded postgresql database. If that's the case, please make sure the embedded database process is running while you start up the Cloudera Manager Server. To check the status of embedded db, you can do

service cloudera-scm-server-db status

sudo /home/cloudera/cloudera-manager --express

This indicates the Cloudera Manager startup runs into an error. What you should do is to check the log file of your Cloudera Manager, which should be located at /var/log/cloudera-scm-server directory. Since this is a POC cluster, I assume that when you set it up, you did not use the external database like MySQL. Instead, you probably used the embedded postgresql database. If that's the case, please make sure the embedded database process is running while you start up the Cloudera Manager Server. To check the status of embedded db, you can do

service cloudera-scm-server-db status
sudo service cloudera-scm-server start
sudo /home/cloudera/cloudera-manager --enterprise
tail -f /var/log/cloudera-scm-server/cloudera-scm-server.log

]https://www.cloudera.com/documentation/enterprise/5-6-x/topics/cm_mc_client_config.html
