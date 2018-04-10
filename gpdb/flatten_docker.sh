#!/bin/bash
# Including configurations
. config.sh

# Build docker image
# echo "Find docker image"
# export CONTAINER_ID=`docker ps | awk '$2 ~ /gpdb5.1/ { print $1}'`


#docker save $DOCKER_TAG > image.tar

docker-squash --output-path squashed.tar $DOCKER_TAG
cat squashed.tar | docker load
docker images $DOCKER_TAG

#
# docker export -o export.tar $CONTAINER_ID
#
# cat export.tar | docker import - $DOCKER_TAG:latest

#docker commit -m "${DOCKER_LABEL}" -a "author" ${CONTAINER_ID} ${DOCKER_TAG}
