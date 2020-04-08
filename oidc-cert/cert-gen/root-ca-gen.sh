#!/bin/bash

if [ -e ${CA_ROOT_CERT} ]; then
  echo "ROOT CA Certificate already created!"
  echo "HINT: If you really want to create a new, delete files from CA directory!"
else
  if [ -d "${CA_DIR}" ]; then
    # remove all other certificates also, because they need to be signed with newly created root-ca
    rm -r ${CA_DIR}/*
  fi
  echo "Generate new ROOT CA ${CA_ROOT_KEY}"
  # Create ROOT CA fo OIDC testlab
  openssl req -x509 -new -nodes -extensions v3_ca \
    -newkey rsa:${SSL_KEY_SIZE} \
    -keyout ${CA_ROOT_KEY} \
    -days ${CA_EXPIRE} \
    -out ${CA_ROOT_CERT} \
    -sha512 \
    -subj '/CN=professos/O=PrOfESSOS OIDC Test Lab./C=DE'
fi
