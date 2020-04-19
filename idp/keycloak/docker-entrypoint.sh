#!/bin/bash
set -e

if [ ! -e /usr/share/pki/ca-trust-source/anchors/${CA_CERT} ]; then
  cp -f ${CA_DIR}/${CA_CERT} /usr/share/pki/ca-trust-source/anchors/${CA_CERT}
  update-ca-trust
fi

/usr/sbin/httpd -D BACKGROUND

su jboss -s /bin/bash -c "/opt/jboss/tools/docker-entrypoint.sh -b 0.0.0.0"
