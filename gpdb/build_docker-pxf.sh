#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Including configurations
. ${DIR}/config.sh


while getopts ":ht:" opt; do
  case $opt in
    t)
      echo "Type for Parameter: $OPTARG" >&2
      ;;
    h)
      echo "To set PXF installation type, use -t with these arguments [cdh|hdp|mapr]" >&2
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
################################################################################
function BuildGreenplumwithPXF()
{
  # echo "Remove docker image with tag:  ${DOCKER_TAG}"
  # if docker images |grep ${DOCKER_TAG}; then
  #      docker rmi -f "${DOCKER_TAG}"
  # fi
  #
  # echo "Building docker for ${GPDB_VERSION}"
  #
  # # https://docs.docker.com/engine/reference/commandline/build/#specifying-target-build-stage-target
  # # Squash to reduce file size
  # docker build --build-arg GPDB_VERSION="${GPDB_VERSION}" --build-arg GPDB_DOWNLOAD="${GPDB_DOWNLOAD}"  --build-arg build_env="${BUILD_ENV}" --force-rm --squash -t "${DOCKER_TAG}" .

  # Build docker image
  echo "Build docker image" # -v /sys /fs/cgroup:/sys/fs/cgroup:ro  \
  docker run --interactive  --privileged --tty -h  "${CONTAINER_NAME}" \
       "${DOCKER_LATEST_TAG}" /bin/bash -c "/usr/local/bin/setupGPDB.sh;/usr/local/bin/setupPXF.sh;/usr/local/bin/startPXF.sh"


  echo "#### Commit docker image"
  export CONTAINER_ID=`docker ps -a -n=1 -q`
  docker commit -m "${DOCKER_LABEL}" -a "author" "${CONTAINER_ID}" "${DOCKER_PXF_TAG}"

  echo "Stop docker image"
  docker stop "${CONTAINER_ID}"
}
################################################################################
function BuildGreenplumwithPXF_USE_GPDBIMAGE()
{
  echo "Remove docker image with tag:  ${DOCKER_PXF_TAG}"
  if docker images |grep "${DOCKER_PXF_TAG}"; then
       docker rmi -f "${DOCKER_PXF_TAG}"
  fi
  # Build docker image from default GPDB image
  echo "Build docker image"
  docker run  --privileged --detach --rm --tty -h "${CONTAINER_NAME}"  \
    -v /sys/fs/cgroup:/sys/fs/cgroup:ro  \
       "${DOCKER_TAG}" "bin/bash"


  export CONTAINER_ID=`docker ps  -q --filter ancestor="${DOCKER_TAG}" --format="{{.ID}}"`
  #
  docker exec  -i -t ${CONTAINER_ID} "/usr/local/bin/startGPDB.sh"
  docker exec  -i -t ${CONTAINER_ID} "/usr/local/bin/setupPXF.sh"
  docker exec  -i -t ${CONTAINER_ID} "/usr/local/bin/startPXF.sh"


  echo "Commit docker image"
  export CONTAINER_ID=`docker ps -a -n=1 -q`
  docker commit -m "${DOCKER_PXF_LABEL}" -a "author" ${CONTAINER_ID} ${DOCKER_PXF_TAG}
}



BuildGreenplumwithPXF


echo  "Stop docker :`docker ps | grep  ${CONTAINER_NAME}  | awk '{print $1}'`"
docker ps | grep  ${CONTAINER_NAME}  | awk '{print $1}' | xargs docker stop
echo "Stop all dockers"
docker stop $(docker ps -aq)

#docker run  -it --hostname=gpdbsne "kochan/gpdb5-pxf"  bin/bash
