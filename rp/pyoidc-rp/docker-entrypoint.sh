#!/bin/bash

while [[ ! -e ${CA_DIR}/${VIRTUAL_HOST}/${VIRTUAL_HOST}.crt ]] ; do
    sleep 1
done

if [ ! -e /usr/local/share/ca-certificates/${CA_CERT} ]; then
  cp -f ${CA_DIR}/${CA_CERT} /usr/local/share/ca-certificates/${CA_CERT}
  update-ca-certificates
fi

while true; do
  response=$(curl -o /dev/null -s -w "%{http_code}\n" https://honest-idp.professos/pyoidc-rp/.well-known/openid-configuration)
  if [[ "$response" != "200" ]]; then
    curl -X POST -d test_id=pyoidc-rp -o /dev/null https://professos/api/rp/create-test-object
    curl -X POST -H "Content-type: application/json" -o /dev/null 'https://professos/api/rp/pyoidc-rp/expose/ID%20Spoofing%201%20-%20ID%20Token%20(sub)'
  elif [[ "$response" == "200" ]]; then
    break;
  fi
  sleep 2
done

while true; do
  response=$(curl -o /dev/null -s -w "%{http_code}\n" https://keycloak/auth/realms/master/.well-known/openid-configuration)
  if [[ "$response" == "200" ]]; then
    break;
  fi
  sleep 2
done

export BASE_URI=https://${VIRTUAL_HOST}
export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
export FLASK_APP=oidc
export FLASK_ENV=development


python oidc.py &

nginx -g 'daemon off;'
