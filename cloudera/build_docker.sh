#!/bin/bash
# Including configurations
. config.sh

echo "Remove docker image"
if docker images |grep ${DOCKER_TAG}; then
    docker rmi -f ${DOCKER_TAG}
fi

echo "docker pull cloudera/quickstart:latest"
docker pull cloudera/quickstart:latest

# Build docker image
echo "Build docker image"
docker run -i -t -h quickstart.cloudera \
    ${DOCKER_TAG} bin/bash

docker run --hostname=quickstart.cloudera --privileged=true -t -i -p 8888:8888 -p 80:80 -p 7180:7180  -p 8020:8020 -p 50075:50075 cloudera/quickstart:latest  /usr/bin/docker-quickstart
echo "Commit docker image"

export CONTAINER_ID=`docker ps -a -n=1 -q`
docker commit -m "${DOCKER_LABEL}" -a "author" ${CONTAINER_ID} ${DOCKER_TAG}
