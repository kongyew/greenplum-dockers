#!/bin/bash
set -e
[[ ${DEBUG} == true ]] && set -x

set -x
# Including configurations
. config.sh
################################################################################
function RunMapR()
{
  echo "[RunMapR] Command:  $1"
  COMMAND=$1

  if [[ -z "${COMMAND}" ]]; then
    echo "Missing command"
    exit -1;
  else
    if [[ "${COMMAND}" == "up" ]]; then
        $DC_MAPR_SCRIPT up
    elif [[ "${COMMAND}" == "down" ]]; then
         $DC_MAPR_SCRIPT down
    else # default option
        $DC_MAPR_SCRIPT up
    fi
  fi
}
################################################################################
function RunCloudera()
{
  echo "[RunCloudera] Command:  $1"
  COMMAND=$1

  if [[ -z "${COMMAND}" ]]; then
    echo "Missing command"
    exit -1;
  else
    if [[ "${COMMAND}" == "up" ]]; then
        $DC_CLOUDERA_SCRIPT up
    elif [[ "${COMMAND}" == "down" ]]; then
         $DC_CLOUDERA_SCRIPT down
    else # default option
        $DC_CLOUDERA_SCRIPT up
    fi
  fi
}
################################################################################
function RunMinio()
{
  echo "[RunMinio] Command:  $1"
  COMMAND=$1

  if [[ -z "${COMMAND}" ]]; then
    echo "Missing command"
    exit -1;
  else
    if [[ "${COMMAND}" == "up" ]]; then
        $DC_MINIO_SCRIPT up
    elif [[ "${COMMAND}" == "down" ]]; then
         $DC_MINIO_SCRIPT down
    else # default option
        $DC_MINIO_SCRIPT up
    fi
  fi
}
################################################################################
function printHelp()
{
    me=$(basename "$0")
    echo "Usage: $me "
    echo "   " >&2
    echo "Options:   " >&2
    echo "-h help  " >&2
    echo "-t Type. For example $ $me -t cloudera  " >&2
    echo "-c command. For example $me -t cloudera -c up  or $me -t cloudera  -c down  " >&2
    echo ""
    echo "For example  " >&2
    echo "$ ./$(basename "$0") -t cloudera -c up " >&2
}
################################################################################
while getopts ":hc:t:" opt; do
  case $opt in
    t)
      echo "Type Parameter: $OPTARG" >&2
      export TYPE=$OPTARG
      ;;
    c)
      echo "Command Parameter: $OPTARG" >&2
      export COMMAND=$OPTARG
      ;;

    h)printHelp
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

export DOCKER_COMPOSE_SCRIPT="docker-compose -f ./docker-compose-gpdb.yml"

if [[ -z "${TYPE}" ]]; then
  echo "Invalid Type"
else
  if [[ "${TYPE}" == "cloudera" ]]; then
      RunCloudera "${COMMAND}"
  elif [[ "${TYPE}" == "mapr" ]]; then
      RunMapR  "${COMMAND}"
  elif [[ "${TYPE}" == "hortonworks" ]]; then
     echo "test"
  elif [[ "${TYPE}" == "minio" ]]; then
      RunMinio  "${COMMAND}"
  else # default option
       echo "test"
  fi
fi




#
# if [[ -z "${COMMAND}" ]]; then
#
# else
#   if [[ "${COMMAND}" == "up" ]]; then
#       $DOCKER_COMPOSE_SCRIPT up
#   elif [[ "${COMMAND}" == "down" ]]; then
#        $DOCKER_COMPOSE_SCRIPT down
#   else # default option
#     $DOCKER_COMPOSE_SCRIPT up
#   fi
# fi
