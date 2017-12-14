#!/bin/bash
# Including configurations
. config.sh

#delete all docker container
docker rm -f $(docker ps -aq)

#check
docker ps -a
###############################################################################
# Remove Image
###############################################################################
echo "Remove docker image with tag:  ${DOCKER_TAG}"
if docker images |grep ${DOCKER_TAG}; then
     docker rmi -f ${DOCKER_TAG}
fi

docker rmi $(docker images -f "dangling=true" -q)

#check
docker images
