#!/bin/bash

export BUILD_ENV="test"
export VOLUME=`pwd`


# Including configurations
. config.sh

docker run  -it --hostname=gpdbsne \
    --name gpdb5pxf \
    --publish 5432:5432 \
    --publish 88:22 \
    --volume ${VOLUME}:/code \
    ${DOCKER_TAG} bin/bash


#SAutomatically delete containers when they exit

#docker exec -it gpdb5 sudo -u gpadmin psql
