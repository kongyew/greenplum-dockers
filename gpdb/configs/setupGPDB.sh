#!/bin/bash
set -e
[[ ${DEBUG} == true ]] && set -x
# Including files
. util.sh

# Get Version
DISTRIBUTION=getDistribution
echo "Distribution: $DISTRIBUTION"
getOSVersion
echo "major_version: $major_version"

check_stat=$(ps -ef | grep 'init' | awk '{print $2}')

if [ -n "$check_stat" ]
then
   echo "init is running"
else
   echo "init isn't running"
   if [ -f /usr/sbin/init ]; then
      /usr/sbin/init &
   fi
fi

check_stat=$(ps -ef | grep '[s]shd' | awk '{print $2}')
if [ -n "$check_stat" ]
then
   echo "SSHD is running"
else
   echo "SSHD isn't running"
   if [ -f /etc/redhat-release ]; then
     if  [ "$major_version" -ge "7" ]; then # "$a" -ge "$b" ]
      #systemctl restart sshd.service
          /usr/bin/ssh-keygen -A
          /usr/sbin/sshd  &
     else
       service sshd start
     fi
   elif [ -f /etc/lsb-release ]; then
       /etc/init.d/ssh start
   elif [ -f /etc/os-release ]; then # SUSE
          /usr/sbin/sshd -D &
   fi
fi


rm -rf /tmp/.s*

# Default environment:
if [ -f /usr/local/greenplum-db/greenplum_path.sh ]; then
  export GPDB_HOME="/usr/local/greenplum-db"
fi

if [ -f /opt/gpdb/greenplum_path.sh ]; then
  export GPDB_HOME="/opt/gpdb"
fi
################################################################################
while getopts ":hg:" opt; do
  case $opt in
    g)
      echo "Greenplum home is : $OPTARG" >&2
      export GPDB_HOME=$OPTARG
      ;;
    h)

      echo "Help: Please specify greenplum home such as  " >&2

      exit 0;
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

# if [ -z ${GPHOME} ]  # if user specify GPHOME in the env , we will use it.
# then
#    export GPDB_HOME=$GPHOME
#    echo "Variable GPDB_HOME:$GPDB_HOME"
# fi
su gpadmin -l -c "source $GPDB_HOME/greenplum_path.sh;gpssh-exkeys -f /tmp/gpdb-hosts"
su gpadmin -l -c "source $GPDB_HOME/greenplum_path.sh;gpinitsystem -a -c  /tmp/gpinitsystem_singlenode -h /tmp/gpdb-hosts; exit 0 "
su gpadmin -l -c "export MASTER_DATA_DIRECTORY=/gpdata/master/gpseg-1;source $GPDB_HOME/greenplum_path.sh;psql -d template1 -c \"alter user gpadmin password 'pivotal'\"; createdb gpadmin;  exit 0"
su gpadmin -l -c "echo \"host all all 0.0.0.0/0 md5\" >> /gpdata/master/gpseg-1/pg_hba.conf"
