#!/bin/bash
set -x # debugging
MAPRVER="5.2.0"
PWD="mapr"

# Docker Checks
if [[ -z $(which docker)  ]] ; then
        echo " docker could not be found on this server. Please install Docker version 1.6.0 or later."
	echo " If it is already installed Please update the PATH env variable."
        exit
fi

dv=$(docker --version | awk '{ print $3}' | sed 's/,//')
if [[ $dv < 1.6.0 ]] ; then
        echo " Docker version installed on this server : $dv.  Please install Docker version 1.6.0 or later."
        exit
fi

CLUSTERNAME="mapr-cluster"
# Find docker id , given the container name
MAPR_CONTROL_DOCKER_ID=$(docker ps -aqf "name=mapr-control")


MAPR_CONTROL_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${MAPR_CONTROL_DOCKER_ID} )

if [ "$MAPR_CONTROL_IP" != "" ]; then
  echo "Control Node IP : $MAPR_CONTROL_IP		Starting the cluster: https://${MAPR_CONTROL_IP}:8443/    login:mapr   password:mapr"
fi

###############################################################################
MAPR_DATA_DOCKER_ID=$(docker ps -aqf "name=mapr-clusterd1")
MAPR_DATA_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${MAPR_DATA_DOCKER_ID} )
if [ "$MAPR_DATA_IP" != "" ]; then
  echo "Data Node IP : $MAPR_DATA_IP		"
fi

if [ -f "/tmp/hosts" ]; then
  rm /tmp/hosts
fi
echo -e "$MAPR_DATA_IP\t${CLUSTERNAME}d1.mapr.io\t${CLUSTERNAME}d1" >> /tmp/hosts

MAPR_DATA_PORT="6022"
###############################################################################
sshpass -p "$PWD" scp -p "$MAPR_DATA_PORT" -o LogLevel=quiet -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no  /tmp/hosts mapr@$MAPR_DATA_IP:/tmp

sshpass -p "$PWD" ssh -p "$MAPR_DATA_PORT" -o LogLevel=quiet -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no mapr@$MAPR_DATA_IP 'sudo cat /tmp/hosts >> /etc/hosts'
