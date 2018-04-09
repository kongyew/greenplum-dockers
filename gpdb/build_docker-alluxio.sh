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
      echo "To set Alluxio installation type, use -t with these arguments [default]" >&2
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

echo "Remove docker image with tag:  ${DOCKER_ALLUXIO_TAG}"
if docker images |grep "${DOCKER_ALLUXIO_TAG}"; then
     docker rmi -f "${DOCKER_ALLUXIO_TAG}"
fi
# Build docker image
echo "Build docker image"
docker run  --privileged --detach --rm --tty -h "${CONTAINER_NAME}"  \
  -v /sys/fs/cgroup:/sys/fs/cgroup:ro  \
     "${DOCKER_LATEST_TAG}" "bin/bash"

export CONTAINER_ID=`docker ps  -q --filter ancestor="${DOCKER_TAG}" --format="{{.ID}}"`

#docker exec  -i -t ${CONTAINER_ID} "/usr/local/bin/startGPDB.sh"
docker exec  -i -t ${CONTAINER_ID} "yum -y install fuse fuse-devel"



#docker exec  -i -t ${CONTAINER_ID} "/usr/local/bin/setupAlluxio.sh"
#docker exec  -i -t ${CONTAINER_ID} "/usr/local/bin/startAlluxio.sh"

echo "Commit docker image"
export CONTAINER_ID=`docker ps -a -n=1 -q`
docker commit -m "${DOCKER_ALLUXIO_LABEL}" -a "author" ${CONTAINER_ID} ${DOCKER_ALLUXIO_TAG}

echo  "Stop docker :`docker ps | grep  ${CONTAINER_NAME}  | awk '{print $1}'`"
docker ps | grep  ${CONTAINER_NAME}  | awk '{print $1}' | xargs docker stop


#docker run  -it --hostname=gpdbsne "kochan/gpdb5-pxf"  bin/bash
