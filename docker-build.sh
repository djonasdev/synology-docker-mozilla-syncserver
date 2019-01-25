#!/bin/sh

cd `dirname $0`

#docker command. You can use "sudo docker" if you need so
DOCKER="docker"
#Image name
IMAGE="djonasdev/synology-docker-mozilla-syncserver"

#Stop the old instance if already running
./docker-stop.sh

# build the new one
$DOCKER build -t $IMAGE ./docker/