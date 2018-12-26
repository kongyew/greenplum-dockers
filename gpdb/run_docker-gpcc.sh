#!/bin/bash
# Including configurations
. config.sh


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Including configurations
. "${DIR}"/config.sh

echo "Stop all docker instances - first"
docker stop $(docker ps -aq)

CONTAINER_ID=$(docker ps -aq --filter name=${CONTAINER_NAME})

if [ "$CONTAINER_ID" != "" ]; then
  docker rm "$CONTAINER_ID"
fi


docker run  -it --hostname=gpdbsne \
    --name ${CONTAINER_NAME} \
    --privileged \
    --publish 5432:5432 \
    --publish 88:22 \
    --publish 28080:28080 \
    --volume /sys/fs/cgroup:/sys/fs/cgroup:ro \
    --volume "${VOLUME}":/code \
    --env START_GPDB=yes \
    --env INSTALL_COMMANDCENTER=yes \
    "${DOCKER_TAG}" bin/bash
