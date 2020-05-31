#!/bin/bash

while [[ ! -e ${CA_DIR}/${VIRTUAL_HOST}/${VIRTUAL_HOST}.crt ]] ; do
    sleep 1
done

if [ ! -e /usr/local/share/ca-certificates/${CA_CERT} ]; then
  cp -f ${CA_DIR}/${CA_CERT} /usr/local/share/ca-certificates/${CA_CERT}
  update-ca-certificates
fi

service apache2 start &


dotnet IdentityServer.dll
