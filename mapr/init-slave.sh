#/bin/bash

service sshd start
export CLDBIP="mapr-control.mapr.io"
IP=$(ip addr show eth0 | grep -w inet | awk '{ print $2}' | cut -d "/" -f1)

echo -e "${IP}\t$(hostname -f).mapr.io\t$(hostname)" >> /etc/hosts
echo -e "${CLDBIP}\t${CLUSTERNAME}c1.mapr.io\t${CLUSTERNAME}c1 " >> /etc/hosts
echo -e "172.20.0.3\tmapr-cluster.mapr.io\tmapr-cluster.mapr.io " >> /etc/hosts

/opt/mapr/server/mruuidgen > /opt/mapr/hostid
cat /opt/mapr/hostid > /opt/mapr/conf/hostid.$$

cp /proc/meminfo /opt/mapr/conf/meminfofake

sed -i "/^MemTotal/ s/^.*$/MemTotal:     ${MEMTOTAL} kB/" /opt/mapr/conf/meminfofake
sed -i "/^MemFree/ s/^.*$/MemFree:     ${MEMTOTAL-10} kB/" /opt/mapr/conf/meminfofake
sed -i "/^MemAvailable/ s/^.*$/MemAvailable:     ${MEMTOTAL-10} kB/" /opt/mapr/conf/meminfofake

sed -i 's/AddUdevRules(list/#AddUdevRules(list/' /opt/mapr/server/disksetup

mkdir -p /opt/mapr/tempdisk && fallocate -l 10G /opt/mapr/tempdisk/docker.disk

echo "/opt/mapr/tempdisk/docker.disk" > /tmp/disks && cat /tmp/disks

/opt/mapr/server/disksetup -F /tmp/disks

echo "/opt/mapr/server/configure.sh -C ${CLDBIP} -Z ${CLDBIP}  -N ${CLUSTERNAME}.mapr.io -u mapr -g mapr -noDB "
/opt/mapr/server/configure.sh -C ${CLDBIP} -Z ${CLDBIP}  -N ${CLUSTERNAME}.mapr.io -u mapr -g mapr -noDB


echo "This container IP : ${IP}"


sleep 60
su - mapr
echo "hadoop fs -mkdir /apps/spark; hadoop fs -chmod 777 /apps/spark"
hadoop fs -mkdir /apps/spark; hadoop fs -chmod 777 /apps/spark
