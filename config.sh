#!/bin/bash
#
#
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export DOCKER_OSS_LABEL="GPDB 5 OSS"
export DOCKER_OSS_TAG="kochanpivotal/gpdb5oss"
export DOCKER_LATEST_OSS_TAG="kochanpivotal/gpdb5oss:latest"

export DC_GPDB_SCRIPT="docker-compose -f ./docker-compose-gpdb.yml"

export DC_CLOUDERA_SCRIPT="docker-compose -f ./cloudera/docker-compose-cloudera.yml"
export DC_MAPR_SCRIPT="docker-compose -f ./mapr/docker-compose-mapr.yml"
export DC_HORTONWORKS_SCRIPT="docker-compose -f ./hortonworks/docker-compose-hortonworks.yml"

export DC_MINIO_SCRIPT="docker-compose -f ./minio/docker-compose-minio.yml"

export DC_POSTGRES9_6_SCRIPT="docker-compose -f ./postgres/docker-compose-postgres9.6.yml"
export DC_POSTGRES8_3_SCRIPT="docker-compose -f ./postgres/docker-compose-postgres8.3.yml"


export DC_SPARK2_1_SCRIPT="docker-compose -f ./spark/docker-compose_spark2-1.yml"
export DC_SPARK2_2_SCRIPT="docker-compose -f ./spark/docker-compose_spark2-2.yml"


# Airflow
export DC_AIRFLOW_SCRIPT="docker-compose -f ./airflow/docker-compose_airflow.yml"
