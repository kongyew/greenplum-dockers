#!/bin/bash
# Including configurations
. config.sh

function tag_and_push {
	if [ -n "$1" ] && [ -n "$IMAGE_NAME" ]; then
		echo "Pushing docker image to hub tagged as $IMAGE_NAME:$1"
v
    #docker build -t $IMAGE_NAME:$1 .
		docker push $IMAGE_NAME:$1
	fi
}
echo "Pushing open source docker image to https://hub.docker.com/r/kochanpivotal/gpdb5oss/"
LATEST_TAG="latest"
export IMAGE_NAME=$DOCKER_OSS_TAG

tag_and_push $LATEST_TAG


# if you see this error "denied: requested access to the resource is denied"
# Make sure you have executed 'docker login'
