#!/bin/bash
set -e
[[ ${DEBUG} == true ]] && set -x

#set -x
# Including configurations
. config.sh




################################################################################
function RunAirFlow()
{
  echo "[RunAirFlow] Command:  $1"
  COMMAND=$1

  if [[ -z "${COMMAND}" ]]; then
    echo "Missing command"
    exit -1;
  else
    if [[ "${COMMAND}" == "up" ]]; then
        $DC_AIRFLOW_SCRIPT up
    elif [[ "${COMMAND}" == "down" ]]; then
         $DC_AIRFLOW_SCRIPT down
    else # default option
        $DC_AIRFLOW_SCRIPT up
    fi
  fi
}

################################################################################
function RunSpark2_2()
{
  echo "[RunSpark2_2] Command:  $1"
  COMMAND=$1

  if [[ -z "${COMMAND}" ]]; then
    echo "Missing command"
    exit -1;
  else
    if [[ "${COMMAND}" == "up" ]]; then
        $DC_SPARK2_2_SCRIPT up
    elif [[ "${COMMAND}" == "down" ]]; then
         $DC_SPARK2_2_SCRIPT down
    else # default option
        $DC_SPARK2_2_SCRIPT up
    fi
  fi
}
################################################################################
function RunSpark2_1()
{
  echo "[RunSpark2_1] Command:  $1"
  COMMAND=$1

  if [[ -z "${COMMAND}" ]]; then
    echo "Missing command"
    exit -1;
  else
    if [[ "${COMMAND}" == "up" ]]; then
        $DC_SPARK2_1_SCRIPT up
    elif [[ "${COMMAND}" == "down" ]]; then
         $DC_SPARK2_1_SCRIPT down
    else # default option
        $DC_SPARK2_1_SCRIPT up
    fi
  fi
}

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
function RunHortonworks()
{
  echo "[RunHortonworks] Command:  $1"
  COMMAND=$1

  if [[ -z "${COMMAND}" ]]; then
    echo "Missing command"
    exit -1;
  else
    if [[ "${COMMAND}" == "up" ]]; then
        $DC_HORTONWORKS_SCRIPT up
    elif [[ "${COMMAND}" == "down" ]]; then
         $DC_HORTONWORKS_SCRIPT down
    else # default option
        $DC_HORTONWORKS_SCRIPT up
    fi
  fi
}



################################################################################
function RunPostgres8_3()
{
  echo "[RunPostgres8_3] Command:  $1"
  COMMAND=$1

  if [[ -z "${COMMAND}" ]]; then
    echo "Missing command"
    exit -1;
  else
    if [[ "${COMMAND}" == "up" ]]; then
        $DC_POSTGRES8_3_SCRIPT up
    elif [[ "${COMMAND}" == "down" ]]; then
         $DC_POSTGRES8_3_SCRIPT down
    else # default option
        $DC_POSTGRES8_3_SCRIPT up
    fi
  fi
}
################################################################################
function RunPostgres9_6()
{
  echo "[RunPostgres9_6] Command:  $1"
  COMMAND=$1

  if [[ -z "${COMMAND}" ]]; then
    echo "Missing command"
    exit -1;
  else
    if [[ "${COMMAND}" == "up" ]]; then
        $DC_POSTGRES9_6_SCRIPT up
    elif [[ "${COMMAND}" == "down" ]]; then
         $DC_POSTGRES9_6_SCRIPT down
    else # default option
        $DC_POSTGRES9_6_SCRIPT up
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
  printHelp
else
  if [[ "${TYPE}" == "cloudera" ]]; then
      RunCloudera "${COMMAND}"
  elif [[ "${TYPE}" == "mapr" ]]; then
      RunMapR  "${COMMAND}"
  elif [[ "${TYPE}" == "hortonworks" ]]; then
     RunHortonworks "${COMMAND}"
  elif [[ "${TYPE}" == "minio" ]]; then
      RunMinio  "${COMMAND}"
  elif [[ "${TYPE}" == "postgres9.6" ]]; then
        RunPostgres9_6  "${COMMAND}"
  elif [[ "${TYPE}" == "postgres8.3" ]]; then
        RunPostgres9_6  "${COMMAND}"
  elif [[ "${TYPE}" == "spark2.1" ]]; then
        RunSpark2_1  "${COMMAND}"
  elif [[ "${TYPE}" == "spark2.2" ]]; then
        RunSpark2_2  "${COMMAND}"
  elif [[ "${TYPE}" == "airflow" ]]; then
        RunAirFlow  "${COMMAND}"
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
