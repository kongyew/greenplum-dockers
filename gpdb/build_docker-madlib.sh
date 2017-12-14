#!/bin/bash
export DOCKER_PXF_LABEL="GPDB5-madlib"
export DOCKER_TAG="kochan/gpdb5"
export DOCKER_LATEST_TAG="kochan/gpdb5"
export DOCKER_PXF_TAG="kochan/gpdb5-madlib:latest"


# echo "Remove docker image"
# if docker images |grep ${DOCKER_TAG}; then
#     docker rmi -f ${DOCKER_TAG}
# fi


# Build docker image
echo "Build docker image"
docker run  --detach --rm --tty -h gpdbsne  \
     ${DOCKER_LATEST_TAG} "/bin/bash"


export CONTAINER_ID=`docker ps  -q --filter ancestor=${DOCKER_LATEST_TAG} --format="{{.ID}}"`

docker exec -i -t ${CONTAINER_ID} "/usr/local/bin/startGPDB.sh"
docker exec -i -t   ${CONTAINER_ID} "/usr/local/bin/setupPXF.sh"
docker exec -i -t   ${CONTAINER_ID} "/usr/local/bin/startPXF.sh"

echo "Commit docker image"
export CONTAINER_ID=`docker ps -a -n=1 -q`
docker commit -m "${DOCKER_PXF_LABEL}" -a "author" ${CONTAINER_ID} ${DOCKER_PXF_TAG}

echo  "Stop docker :`docker ps | grep 'gpdb5.1' | awk '{print $1}'`"
docker ps | grep 'gpdb5.1' | awk '{print $1}' | xargs docker stop


#docker run  -it --hostname=gpdbsne "kochan/gpdb5-pxf"  bin/bash
