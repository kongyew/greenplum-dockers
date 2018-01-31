#!/bin/bash


# Including configurations
. config.sh


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

echo "Remove docker image with tag:  ${DOCKER_PXF_TAG}"
if docker images |grep ${DOCKER_PXF_TAG}; then
     docker rmi -f ${DOCKER_PXF_TAG}
fi
# Build docker image
echo "Build docker image"
docker run   --privileged --detach --rm --tty -h ${CONTAINER_NAME}  \
  -v /sys/fs/cgroup:/sys/fs/cgroup:ro  \
     ${DOCKER_LATEST_TAG} "bin/bash"

export CONTAINER_ID=`docker ps  -q --filter ancestor=${DOCKER_TAG} --format="{{.ID}}"`

docker exec  -i -t ${CONTAINER_ID} "/usr/local/bin/startGPDB.sh"
docker exec  -i -t ${CONTAINER_ID} "/usr/local/bin/setupPXF.sh"
docker exec  -i -t ${CONTAINER_ID} "/usr/local/bin/startPXF.sh"

echo "Commit docker image"
export CONTAINER_ID=`docker ps -a -n=1 -q`
docker commit -m "${DOCKER_PXF_LABEL}" -a "author" ${CONTAINER_ID} ${DOCKER_PXF_TAG}

echo  "Stop docker :`docker ps | grep  ${CONTAINER_NAME}  | awk '{print $1}'`"
docker ps | grep  ${CONTAINER_NAME}  | awk '{print $1}' | xargs docker stop


#docker run  -it --hostname=gpdbsne "kochan/gpdb5-pxf"  bin/bash
