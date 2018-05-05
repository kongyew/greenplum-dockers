#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Including configurations
. ${DIR}/config.sh

echo "Find docker image with tag:  ${DOCKER_PXF_TAG}"
  if docker images |grep "${DOCKER_PXF_TAG}"; then
    echo "docker save ${DOCKER_PXF_TAG} > ./pxf.tar "
    docker save ${DOCKER_PXF_TAG} > ./pxf.tar
    echo "If you want load this image, use this command $ docker load ./pxf.tar"
  else
    echo "Error : Cannot find this image :  ${DOCKER_PXF_TAG}"
    exit 1
  fi

 du -sh *.tar
