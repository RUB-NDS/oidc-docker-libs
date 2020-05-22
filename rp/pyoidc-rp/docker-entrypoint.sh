#!/bin/bash

if [ ! -e /usr/local/share/ca-certificates/${CA_CERT} ]; then
  cp -f ${CA_DIR}/${CA_CERT} /usr/local/share/ca-certificates/${CA_CERT}
  update-ca-certificates
fi

python rp.py -p 4242 -b https://pyoidc-rp settings.yaml &

nginx -g 'daemon off;'
