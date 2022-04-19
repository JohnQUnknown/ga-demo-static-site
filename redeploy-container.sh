#!/bin/bash

set -x -o pipefail

CONTAINER=$(docker ps --format '{{ .ID }} {{ .Names }}' | grep $1)

if [ ! -z "$CONTAINER" ]
then
    echo "Container running"
    CONTAINER_ID=$(echo "$CONTAINER" | cut -d' ' -f1)
    echo "ID: $CONTAINER_ID"
    echo "Stopping container"
    docker stop $CONTAINER_ID
    docker rm $CONTAINER_ID
    docker run -d --name $1 -p "80:80" $2 
else
    echo "Container not running"
    echo "Starting container"
    docker run -d --name $1 -p "80:80" $2
fi
