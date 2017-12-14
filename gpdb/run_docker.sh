#!/bin/bash
export DOCKER_TAG="kochan/gpdb5"
export GPDB_VERSION="5.2.0-rhel6-x86_64"
export BUILD_ENV="test"
export VOLUME=`pwd`

docker run  -it --hostname=gpdbsne \
    --name gpdb5 \
    --publish 5432:5432 \
    --publish 88:22 \
    --volume ${VOLUME}:/code \
    ${DOCKER_TAG} bin/bash
    #--link 260_namenode_1:260_namenode_1 \

#SAutomatically delete containers when they exit

#docker exec -it gpdb5 sudo -u gpadmin psql
