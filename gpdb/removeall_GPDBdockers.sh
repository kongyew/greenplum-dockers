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

echo "Remove docker image with tag:  ${DOCKER_PXF_TAG}"
if docker images |grep "${DOCKER_PXF_TAG}"; then
     docker rmi -f "${DOCKER_PXF_TAG}"
fi


echo "Remove docker image with tag:  ${DOCKER_MADLIB_TAG}"
if docker images |grep ${DOCKER_MADLIB_TAG}; then
     docker rmi -f ${DOCKER_MADLIB_TAG}
fi

echo "Remove docker image with tag:  ${DOCKER_ALLUXIO_TAG}"
if docker images |grep "${DOCKER_ALLUXIO_TAG}"; then
     docker rmi -f "${DOCKER_ALLUXIO_TAG}"
fi

docker rmi $(docker images -f "dangling=true" -q)

#check
docker images
