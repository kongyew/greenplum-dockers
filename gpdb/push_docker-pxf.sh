#!/bin/bash
# Including configurations
. config.sh

function tag_and_push {
	if [ -n "$1" ] && [ -n "$IMAGE_NAME" ]; then
		echo "Pushing docker image to hub tagged as $IMAGE_NAME:$1"
    docker tag $1 $IMAGE_NAME
    #docker build -t $IMAGE_NAME:$1 .
		docker push $IMAGE_NAME:$1
	fi
}

echo "Pushing open source docker image to https://hub.docker.com/r/kochanpivotal/$DOCKER_PXF_TAG/"
LATEST_TAG="latest"
export IMAGE_NAME=$DOCKER_PXF_TAG

tag_and_push $LATEST_TAG
