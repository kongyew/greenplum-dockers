#!/bin/bash
# Including configurations
. config.sh

echo "Remove docker image"
if docker images |grep ${DOCKER_MADLIB_TAG}; then
     docker rmi -f ${DOCKER_MADLIB_TAG}
fi

# Build docker image
echo "Build docker image"
docker run  --detach --rm --tty -h gpdbsne \
    --privileged \
    -e START_GPDB=yes  \
     ${DOCKER_TAG} -sh -c "/bin/bash"
export CONTAINER_ID=`docker ps  -q --filter ancestor=${DOCKER_TAG} --format="{{.ID}}"`

#docker exec -i -t   --privileged ${CONTAINER_ID} "/usr/local/bin/startGPDB.sh"
docker exec -i -t ${CONTAINER_ID} sh -c "/usr/local/bin/startGPDB.sh && /opt/madlib/setupMadlib.sh"

echo "Commit docker image"
export CONTAINER_ID=`docker ps -a -n=1 -q`
docker commit -m "${DOCKER_MADLIB_LABEL}" -a "author" ${CONTAINER_ID} ${DOCKER_MADLIB_TAG}

echo  "Stop docker :`docker ps | grep 'gpdb' | awk '{print $1}'`"
docker ps | grep 'gpdb' | awk '{print $1}' | xargs docker stop
