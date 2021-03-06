#!/bin/bash
# Including configurations
. config.sh

export BUILD_ENV="test"
export VOLUME=`pwd`
export START_GPDB="yes"


docker run  -it --hostname=gpdbsne \
    --name gpdb5madlib \
    --privileged \
    --publish 5432:5432 \
    --publish 88:22 \
    --publish 28080:28080 \
    --volume ${VOLUME}:/code \
    -e START_GPDB=yes \
    ${DOCKER_MADLIB_TAG} bin/bash
    #--link 260_namenode_1:260_namenode_1 \
