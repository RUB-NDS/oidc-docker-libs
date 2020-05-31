#!/bin/bash

CA_ROOT_CERT=${CA_DIR}/${CA_CERT}
CA_ROOT_KEY=${CA_DIR}/${CA_KEY}

if [ -z ${CA_DIR} ]; then
    echo "Empty certification directory, stop processing!"
    exit 1
fi

# Warn if the DOCKER_HOST socket does not exist
if [[ $DOCKER_HOST = unix://* ]]; then
	socket_file=${DOCKER_HOST#unix://}
	if ! [ -S $socket_file ]; then
    echo "socket ${socket_file} not found!"
	fi
fi

# generate a new root ca if no certificate is found
. ./root-ca-gen.sh
. ./cert-sign.sh

docker-gen hosts.tpl hosts

create_ssl_certificates $CONTROLLER_HOST
create_ssl_certificates $HONEST_OP_HOST
create_ssl_certificates $EVIL_OP_HOST
create_ssl_certificates $HONEST_RP_HOST
create_ssl_certificates $EVIL_RP_HOST

for DOMAIN_NAME in $(cat hosts)
do
  create_ssl_certificates ${DOMAIN_NAME}
done
