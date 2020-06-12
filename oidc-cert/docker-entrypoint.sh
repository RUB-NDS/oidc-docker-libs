#!/bin/bash

# Warn if the DOCKER_HOST socket does not exist
if [[ $DOCKER_HOST = unix://* ]]; then
	socket_file=${DOCKER_HOST#unix://}
	if ! [ -S $socket_file ]; then
    echo "socket ${socket_file} not found!"
	fi
fi

echo "cert-gen: docker-gen -watch -notify \"/cert-gen/cert-gen.sh\" hosts.tpl hosts" >> Procfile
forego start -r
