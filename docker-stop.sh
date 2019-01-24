#!/bin/sh
#Stop and remove the docker container

#docker command. You can use "sudo docker" if you need so
DOCKER="docker"
#Image name
IMAGE="djonasdev/synology-docker-mozilla-syncserver"

#Stop the old instance if already running
$DOCKER rm $($DOCKER stop $($DOCKER ps -a -q --filter ancestor=$IMAGE --format="{{.ID}}"))