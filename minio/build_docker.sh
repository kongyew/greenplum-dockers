#!/bin/bash
# Including configurations
. config.sh


echo "Remove docker image with tag:  ${DOCKER_TAG}"
if docker images |grep ${DOCKER_TAG}; then
     docker rmi -f "${DOCKER_TAG}"
fi

echo "Building docker for ${DOCKER_TAG}"

# https://docs.docker.com/engine/reference/commandline/build/#specifying-target-build-stage-target
# Squash to reduce file size
docker build  --force-rm --squash -t "${DOCKER_TAG}" -f minioClientDockerfile .

# Build docker image
# echo "Build docker image"
# docker run --interactive  --privileged --tty -h "${CONTAINER_NAME}" \
#       -v /sys /fs/cgroup:/sys/fs/cgroup:ro  \
#      "${DOCKER_TAG}" /bin/bash -c "ls -la /opt"
#
# echo "Commit docker image"
# export CONTAINER_ID=`docker ps -a -n=1 -q`
# docker commit -m "${DOCKER_LABEL}" -a "author" "${CONTAINER_ID}" "${DOCKER_LATEST_TAG}"
#
# echo "Stop docker image"
# docker stop "${CONTAINER_ID}"
