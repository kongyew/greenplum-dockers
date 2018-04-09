#!/bin/bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Including configurations
. "${DIR}"/config.sh

docker run  -it -h minioclient \
    --publish 11000:11000 \
    --publish 50070:50070 \
    --volume /tmp:/tmp/volume \
    ${DOCKER_TAG} "/bin/sh -c minio/mc"
