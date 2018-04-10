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

docker exec  -i -t ${CONTAINER_ID} "/usr/local/bin/startGPDB.sh"
docker exec  -i -t ${CONTAINER_ID} "/usr/local/bin/setupPXF.sh"
docker exec  -i -t ${CONTAINER_ID} "/usr/local/bin/setupPXFHadoop.sh"
docker exec  -i -t ${CONTAINER_ID} "/usr/local/bin/startPXF.sh"
docker exec  -i -t ${CONTAINER_ID} "/usr/bin/rm greenplum-db-*.bin"
docker exec  -i -t ${CONTAINER_ID} "/usr/bin/bash"

echo "Commit docker image"
export CONTAINER_ID=`docker ps -a -n=1 -q`
docker commit -m "${DOCKER_PXF_LABEL}" -a "author" ${CONTAINER_ID} ${DOCKER_PXF_TAG}

# Export images to a file
#docker save ${DOCKER_PXF_TAG} > /tmp/PXF.tar

# docker commit -m "GPDB 5-PXF" -a "author" ${CONTAINER_ID} kochanpivotal/gpdb5-pxf

echo  "Stop docker :`docker ps | grep  ${CONTAINER_NAME}  | awk '{print $1}'`"
docker ps | grep  ${CONTAINER_NAME}  | awk '{print $1}' | xargs docker stop

echo "Stop all dockers"
docker stop $(docker ps -aq)

#docker run  -it --hostname=gpdbsne "kochan/gpdb5-pxf"  bin/bash
