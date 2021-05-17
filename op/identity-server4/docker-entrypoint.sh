#!/bin/bash

if [ ! -z CA_DIR ] && [ ! -z CA_CERT ]; then
  while [ ! -f "${CA_DIR}/${CA_CERT}" ]; do echo "ca cert not generated yet - sleeping"; sleep 1; done;
fi;

while [[ ! -e ${CA_DIR}/${VIRTUAL_HOST}/${VIRTUAL_HOST}.crt ]] ; do
    sleep 1
done

if [ ! -e /usr/local/share/ca-certificates/${CA_CERT} ]; then
  cp -f ${CA_DIR}/${CA_CERT} /usr/local/share/ca-certificates/${CA_CERT}
  update-ca-certificates
fi

service apache2 start &


dotnet IdentityServer.dll
