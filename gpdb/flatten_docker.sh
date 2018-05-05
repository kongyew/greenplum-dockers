#!/bin/bash
# Including configurations
. config.sh


# echo "docker-squash --output-path squashed.tar $DOCKER_LATEST_TAG -t $DOCKER_LATEST_TAG"
docker-squash --output-path squashed.tar $DOCKER_LATEST_TAG -t $DOCKER_LATEST_TAG
cat squashed.tar | docker load
docker images $DOCKER_LATEST_TAG


#docker-squash $DOCKER_LATEST_TAG -t $DOCKER_LATEST_TAG | docker load
