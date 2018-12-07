#!/bin/bash
# Including configurations
. config.sh

export BUILD_ENV="test"
export VOLUME=`pwd`
export START_GPDB="yes"

docker ps --filter "name=$DOCKER_LATEST_TAG"


docker run  -it --hostname=gpdbsne \
    --name gpdb5 \
    --privileged \
    --publish 5432:5432 \
    --publish 88:22 \
    --publish 28080:28080 \
    --volume ${VOLUME}:/code \
    -e START_GPDB=yes \
    -e SETUP_PG_HBA=yes \
    ${DOCKER_LATEST_TAG} bin/bash
    #--link 260_namenode_1:260_namenode_1 \
