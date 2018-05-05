#!/bin/bash
# Including configurations
. config.sh



# docker-squash --output-path squashed.tar $DOCKER_PXF_TAG
# cat squashed.tar | docker load
# docker images $DOCKER_PXF_TAG


docker-squash --output-path squashed.tar $DOCKER_PXF_LATEST_TAG -t $DOCKER_PXF_LATEST_TAG
cat squashed.tar | docker load
docker images $DOCKER_PXF_LATEST_TAG
