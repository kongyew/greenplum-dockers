#!/bin/bash

export BUILD_ENV="test"
VOLUME=$(pwd)
CONTAINER_NAME='gpdb5pxf'

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Including configurations
. "${DIR}"/config.sh


CONTAINER_ID=$(docker ps -aq --filter name=${CONTAINER_NAME})

if [ "$CONTAINER_ID" != "" ]; then
  docker rm "$CONTAINER_ID"
fi


docker run  -it --hostname=gpdbsne \
    --name ${CONTAINER_NAME} \
    --privileged \
    --publish 5432:5432 \
    --publish 88:22 \
    --volume /sys/fs/cgroup:/sys/fs/cgroup:ro \
    --volume "${VOLUME}":/code \
    "${DOCKER_TAG}" bin/bash
