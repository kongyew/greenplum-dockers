#!/bin/bash
set -e
[[ ${DEBUG} == true ]] && set -x

if [[ ! "$(whoami)" =~ ^(gpadmin|root)$ ]]
then
    echo "Please run the script as gpadmin or root" >&2
    exit 1
fi

current=`pwd`
. ./util.sh


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

if [[ -z "$GPHOME" ]]  # if user specify GPHOME in the env , we will use it.
then
  if [ "$GPHOME" != "" ]
  then
      export GPDB_HOME=$GPHOME
  fi
fi
################################################################################
if [[ -z "${GPDB_HOME}" ]]
then
  echo "Unable to find environment variables [GPHOME]:$GPDB_HOME"
  exit 1
else

    if [ "$(whoami)" == "gpadmin" ]; then
        source ${GPDB_HOME}/greenplum_path.sh
        echo -e "Y\n" |   gpperfmon_install --enable --password changeme --port 5432
        gpstop -r
        psql -U gpmon gpperfmon -c 'SELECT * FROM system_now;'
    else
        su gpadmin -l -c "source ${GPDB_HOME}/greenplum_path.sh;echo -e \"y\\n\" |    gpperfmon_install --enable --password changeme --port 5432"
        su gpadmin -l -c "source ${GPDB_HOME}/greenplum_path.sh;gpstop -r"
        su gpadmin -l -c "source ${GPDB_HOME}/greenplum_path.sh;psql -U gpmon gpperfmon -c 'SELECT * FROM system_now;'"
    fi
fi
