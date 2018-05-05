#!/bin/bash
# Including configurations
. config.sh


if [ -e ${HORTON_TAR_FILE} ]
then
  echo "docker load < ${HORTON_TAR_FILE}"
  docker load < ${HORTON_TAR_FILE}
else
    echo "Cannot find this file: ${HORTON_TAR_FILE}"
    exit 1
fi

#docker tag $HORTONWORKS_TAG $DOCKER_TAG

echo "Find docker image with tag:  ${DOCKER_HORTONWORKS_TAG}"
if docker images |grep "${DOCKER_HORTONWORKS_TAG}"; then

  # Build docker image
  echo "Build docker image"
  docker run -it -h sandbox-hdp  ${DOCKER_HORTONWORKS_TAG} bin/bash
  # docker run --interactive  --privileged --tty -h "${CONTAINER_NAME}" \
  #       -v /sys /fs/cgroup:/sys/fs/cgroup:ro  \
  #      "${DOCKER_TAG}" /bin/bash -c "ls -la /opt"

  echo "Commit docker image"
  export CONTAINER_ID=`docker ps -a -n=1 -q`
  docker commit -m "${DOCKER_LABEL}" -a "author" "${CONTAINER_ID}" "${DOCKER_LATEST_TAG}"

  echo "Stop docker image"
  docker stop "${CONTAINER_ID}"
else
  echo "Cannot find docker image ${DOCKER_HORTONWORKS_TAG}"

fi
