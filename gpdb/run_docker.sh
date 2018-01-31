#!/bin/bash
# Including configurations
. config.sh

export BUILD_ENV="test"
export VOLUME=`pwd`

docker run  -it --hostname=gpdbsne \
    --name gpdb5 \
    --privileged \
    --publish 5432:5432 \
    --publish 88:22 \
    --volume ${VOLUME}:/code \
    ${DOCKER_TAG} bin/bash
    #--link 260_namenode_1:260_namenode_1 \
