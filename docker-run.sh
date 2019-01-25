#!/bin/sh
#Run a mozilla syncserver docker container with host folder as a volume

#Default volume path on host.
VOLUME_PATH="/home/docker/ff-sync"
#Container hostname
CONTAINER_HOSTNAME="ff-sync.domain.com"
#Container name
CONTAINER_NAME="ff-sync"
#Restart policy
RESTART_POLICY="unless-stopped"
#Some extra arguments. Like -d ant -ti
EXTRA_ARGS="-d"
#docker command. You can use "sudo docker" if you need so
DOCKER="docker"
#Extra args to docker command. Like using remote dockerd or something else
DOCKER_ARGS=""

#Image name
IMAGE="djonasdev/synology-docker-mozilla-syncserver"

#Stop the old instance if already running
./docker-stop.sh

[ ! -z "$CONTAINER_HOSTNAME" ] && CONTAINER_HOSTNAME="--hostname=$CONTAINER_HOSTNAME"
[ ! -z "$CONTAINER_NAME" ]     && CONTAINER_NAME="--name=$CONTAINER_NAME"
[ ! -z "$RESTART_POLICY" ]      && RESTART_POLICY="--restart=$RESTART_POLICY"

$DOCKER $DOCKER_ARGS run \
	-v $VOLUME_PATH:/data \
	-p 127.0.0.1:5000:5000 \
	$CONTAINER_HOSTNAME \
	$CONTAINER_NAME \
	$RESTART_POLICY \
	$EXTRA_ARGS \
	$IMAGE
