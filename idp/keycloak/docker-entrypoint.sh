#!/bin/bash
set -e

if [ ! -e /usr/share/pki/ca-trust-source/anchors/${CA_CERT} ]; then
  cp -f ${CA_DIR}/${CA_CERT} /usr/share/pki/ca-trust-source/anchors/${CA_CERT}
  update-ca-trust
fi

/usr/sbin/httpd -D BACKGROUND

if [ ! -z "$HTTP_PROXY_URL" ]; then
  PROXY_SETTINGS="-Dhttp.proxyHost=${HTTP_PROXY_URL} -Dhttp.proxyPort=${HTTP_PROXY_PORT}
                 -Dhttps.proxyHost=${HTTP_PROXY_URL} -Dhttps.proxyPort=${HTTP_PROXY_PORT}
                 -Dhttp.nonProxyHosts='localhost'"
fi

su jboss -s /bin/bash -c "/opt/jboss/tools/docker-entrypoint.sh -b 0.0.0.0 $PROXY_SETTINGS"
