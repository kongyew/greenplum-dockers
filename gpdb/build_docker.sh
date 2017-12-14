#!/bin/bash
set -e


# Including configurations
. config.sh

while getopts ":hi:" opt; do
  case $opt in
    i)
      echo "Type for Parameter: $OPTARG" >&2
      export GPDB_VERSION=$OPTARG
      ;;
    h) # GPDB_VERSION="5.2.0-rhel6-x86_64"
      echo "To install GPDB version, use -i to specify version such as 5.1.0-rhel6-x86_64 | 5.2.0-rhel6-x86_64 " >&2
      exit 0;
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done


echo "Remove docker image with tag:  ${DOCKER_TAG}"
if docker images |grep ${DOCKER_TAG}; then
     docker rmi -f ${DOCKER_TAG}
fi

echo Building docker for ${GPDB_VERSION}
#--build-arg GPDB_VERSION=${GPDB_VERSION}

# https://docs.docker.com/engine/reference/commandline/build/#specifying-target-build-stage-target
# Squash to reduce file size
docker build --build-arg GPDB_VERSION=${GPDB_VERSION} --force-rm --squash -t ${DOCKER_TAG} .

# Build docker image
echo "Build docker image"
docker run --interactive --tty -h ${CONTAINER_NAME} \
     ${DOCKER_TAG} /bin/bash -c "/usr/local/bin/setupGPDB.sh;/usr/local/bin/stopGPDB.sh"

echo "Commit docker image"
export CONTAINER_ID=`docker ps -a -n=1 -q`
docker commit -m "${DOCKER_LABEL}" -a "author" ${CONTAINER_ID} ${DOCKER_LATEST_TAG}
