#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Including configurations
. ${DIR}/config.sh

export SUSE_TAR="gpdb5suse.tar"

echo "Find docker image with tag:  ${DOCKER_SUSE_LATEST_TAG}"
  if docker images |grep "${DOCKER_SUSE_LATEST_TAG}"; then
    echo "docker save ${DOCKER_SUSE_LATEST_TAG} > ./${SUSE_TAR} "
    docker save ${DOCKER_SUSE_LATEST_TAG} > ./${SUSE_TAR}
    echo "If you want load this image, use this command $ docker load ./${SUSE_TAR}"
  else
    echo "Error : Cannot find this image :  ${DOCKER_SUSE_LATEST_TAG}"
    exit 1
  fi

 du -sh *.tar
