#!/bin/bash
export DOCKER_LABEL="GPDB 5.1"
export DOCKER_TAG="kochan/gpdb5.1"
export GPDB_VERSION="5.1.0-rhel6-x86_64"


# Build docker image
echo "Find docker image"
export CONTAINER_ID=`docker ps | awk '$2 ~ /gpdb5.1/ { print $1}'`
docker export -o export.tar $CONTAINER_ID

cat export.tar | docker import - $DOCKER_TAG:latest

#docker commit -m "${DOCKER_LABEL}" -a "author" ${CONTAINER_ID} ${DOCKER_TAG}
