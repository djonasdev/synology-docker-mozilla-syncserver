#!/bin/sh

cd `dirname $0`

docker build -t djonasdev/synology-docker-mozilla-syncserver ./docker/
