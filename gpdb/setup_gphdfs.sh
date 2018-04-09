#!/bin/bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Including configurations
. "${DIR}"/config.sh
################################################################################
function SetupGPHDFS_MapR()
{
  echo "Setup GPHDFS with MapR"
  docker run --interactive  --privileged --tty -h "${CONTAINER_NAME}" \
  "${DOCKER_TAG}" /bin/bash -c "/usr/local/bin/startGPDB.sh;runuser -l gpadmin -c '/opt/gphdfs/setupGPHDFS.sh -i mapr';exit 0;"
  echo "Commit docker image"
  export CONTAINER_ID=`docker ps -a -n=1 -q`
  docker commit -m "${DOCKER_LABEL}" -a "author" "${CONTAINER_ID}" "${DOCKER_LATEST_TAG}"

  echo "Stop docker image"
  docker stop "${CONTAINER_ID}"
}
function SetupGPHDFS_CDH()
{
  echo "Setup GPHDFS with CDH"
  docker run --interactive  --privileged --tty -h "${CONTAINER_NAME}" \
  "${DOCKER_TAG}" /bin/bash -c "/usr/local/bin/startGPDB.sh;runuser -l gpadmin -c '/opt/gphdfs/setupGPHDFS.sh -i cdh';exit 0;"

  echo "Commit docker image"
  export CONTAINER_ID=`docker ps -a -n=1 -q`
  docker commit -m "${DOCKER_LABEL}" -a "author" "${CONTAINER_ID}" "${DOCKER_LATEST_TAG}"


  echo "Stop docker image"
  docker stop "${CONTAINER_ID}"
}
function SetupGPHDFS_HDP()
{
  echo "Setup GPHDFS with HDP"
  docker run --interactive  --privileged --tty -h "${CONTAINER_NAME}" \
  "${DOCKER_TAG}" /bin/bash -c "/usr/local/bin/startGPDB.sh;runuser -l gpadmin -c '/opt/gphdfs/setupGPHDFS.sh -i hdp';exit 0;"

  echo "Commit docker image"
  export CONTAINER_ID=`docker ps -a -n=1 -q`
  docker commit -m "${DOCKER_LABEL}" -a "author" "${CONTAINER_ID}" "${DOCKER_LATEST_TAG}"


  echo "Stop docker image"
  docker stop "${CONTAINER_ID}"
}

################################################################################
#
# Main function
#
################################################################################

while getopts ":hi:" opt; do
  case $opt in
    i)
      echo "Type for Parameter: $OPTARG" >&2
      export HADOOP_DISTRIBUTION=$OPTARG
      ;;

    h)

      me=$(basename "$0")
      echo "Usage: $me "
      echo "   " >&2
      echo "Options:   " >&2
      echo "-h \thelp  " >&2
      echo "  " >&2
      echo "To install Pivotal GPDB (Centos) version, use -i to specify version such as 5.4.1-rhel6-x86_64 = " >&2
      echo "To install Pivotal GPDB (SUSE) version, use -i to specify version such as sles11-x86_64 " >&2
      echo "To install Open source Greenplum version, use -i to specify version such as opensource or sles11-x86_64 " >&2
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

if [ -n "$HADOOP_DISTRIBUTION" ]
then
  if [ "$HADOOP_DISTRIBUTION" == "mapr" ]
  then
      SetupGPHDFS_MapR
  elif [ "$GPDB_VERSION" == "cdh" ]
    then
      SetupGPHDFS_CDH
  else # default option to build Centos if nothing is specified
      echo 'Build Greenplum using "${GPDB_VERSION}" '

  fi
else
  echo 'Variable "${HADOOP_DISTRIBUTION}" does not exist!'
fi
