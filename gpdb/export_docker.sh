#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Including configurations
. ${DIR}/config.sh

echo "Find docker image with tag:  ${DOCKER_TAG}"
  if docker images |grep "${DOCKER_TAG}"; then
    echo "docker save ${DOCKER_TAG} > ./gpdb5.tar "
    docker save ${DOCKER_TAG} > ./gpdb5.tar
    echo "If you want load this image, use this command $ docker load ./pxf.tar"
  else
    echo "Error : Cannot find this image :  ${DOCKER_TAG}"
    exit 1
  fi

 du -sh *.tar
