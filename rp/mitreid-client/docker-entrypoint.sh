#!/bin/bash

if [ ! -e /usr/local/share/ca-certificates/${CA_CERT} ]; then
  cp -f ${CA_DIR}/${CA_CERT} /usr/local/share/ca-certificates/${CA_CERT}
  update-ca-certificates

  keytool -keystore /usr/local/openjdk-8/lib/security/cacerts -storepass changeit -noprompt -trustcacerts \
          -importcert -alias oidc -file /usr/share/ca-certificates/${CA_CERT}
fi

service apache2 start &

if [ ! -z "$HTTP_PROXY_URL" ]; then
  PROXY_SETTINGS="-Dhttp.proxyHost=${HTTP_PROXY_URL} -Dhttp.proxyPort=${HTTP_PROXY_PORT} -Dhttps.proxyHost=${HTTP_PROXY_URL} -Dhttps.proxyPort=${HTTP_PROXY_PORT} -Dhttp.nonProxyHosts='localhost'"
fi

su jboss -s /bin/bash -c "/opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0 $PROXY_SETTINGS"
