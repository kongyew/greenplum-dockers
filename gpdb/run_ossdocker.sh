#!/bin/bash
# Including configurations
. config.sh

export BUILD_ENV="test"
export VOLUME=`pwd`
export START_GPDB="yes"

docker run  -it --hostname=gpdbsne \
    --name gpdb5oss \
    --privileged \
    --publish 5432:5432 \
    --publish 88:22 \
    -e START_GPDB=yes \
    --volume ${VOLUME}:/code \
    ${DOCKER_OSS_TAG} bin/bash
