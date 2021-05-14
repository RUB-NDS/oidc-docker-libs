#!/usr/bin/env bash

trap 'kill ${!}; term_handler' SIGHUP SIGINT SIGQUIT SIGTERM

pid=0

term_handler() {
  echo "term_handler"
  service ntp stop
  if [ $pid -ne 0 ]; then
    kill -SIGTERM "$pid"
    wait "$pid"
  fi
  exit 143; # 128 + 15 -- SIGTERM
}

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

service ntp start
service apache2 start

export NODE_OPTIONS=--use-openssl-ca
export HTTPS_PROXY=$https_proxy
export HTTP_PROXY=$http_proxy
npm config set proxy ${http_proxy} -g
npm config set https-proxy ${https_proxy} -g

echo -n "Starting login demo"
npm start &

pid="$!"
if [ $? -eq 0 ] ; then
  echo "OK"
else
  echo "ERROR"
  exit -1
fi

while true
do
  tail -f /dev/null & wait ${!}
done

echo "exited $0"
