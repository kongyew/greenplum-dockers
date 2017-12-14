#!/bin/bash
export DOCKER_LABEL="hortonworks"
export DOCKER_TAG="kochan/hortonworks"

# echo "Remove docker image"
# if docker images |grep ${DOCKER_TAG}; then
#     docker rmi -f ${DOCKER_TAG}
# fi

#docker pull cloudera/quickstart:latest
echo "docker load -i <sandbox-docker-image-path>"
docker load -i HDP_2_6_1_docker_image_28_07_2017_14_42_40.tar
docker tag $DOCKER_TAG sandbox-hdf
# Build docker image
echo "Build docker image"
docker run -i -t -h sandbox-hdf \
    ${DOCKER_TAG} bin/bash


#docker run --hostname=quickstart.cloudera --privileged=true -t -i -p 8888:8888 -p 80:80 -p 7180:7180  -p 8020:8020 -p 50075:50075 kochan/cloudera:latest  /usr/bin/docker-quickstart
#echo "Commit docker image"

#export CONTAINER_ID=`docker ps -a -n=1 -q`
#docker commit -m "${DOCKER_LABEL}" -a "author" ${CONTAINER_ID} ${DOCKER_TAG}
