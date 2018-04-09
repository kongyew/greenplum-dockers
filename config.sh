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
export DC_MINIO_SCRIPT="docker-compose -f ./minio/docker-compose-minio.yml"
