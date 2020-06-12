#!/bin/bash

CA_ROOT_CERT=${CA_DIR}/${CA_CERT}
CA_ROOT_KEY=${CA_DIR}/${CA_KEY}

if [ -z ${CA_DIR} ]; then
    echo "Empty certification directory, stop processing!"
    exit 1
fi



# generate a new root ca if no certificate is found
. ./root-ca-gen.sh
. ./cert-sign.sh


create_ssl_certificates $CONTROLLER_HOST
create_ssl_certificates $HONEST_OP_HOST
create_ssl_certificates $EVIL_OP_HOST
create_ssl_certificates $HONEST_RP_HOST
create_ssl_certificates $EVIL_RP_HOST

for DOMAIN_NAME in $(cat hosts)
do
  create_ssl_certificates ${DOMAIN_NAME}
done
