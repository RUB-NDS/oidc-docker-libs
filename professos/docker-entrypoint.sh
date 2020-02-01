#!/bin/bash

#TODO use ENV variables
if [ ! -e /usr/local/share/ca-certificates/CA_CERT ]; then
  cp -f CA_DIR/CA_CERT /usr/local/share/ca-certificates/CA_CERT
  update-ca-certificates

  keytool -keystore /usr/local/openjdk-11/lib/security/cacerts -storepass changeit -noprompt -trustcacerts \
          -importcert -alias oidc -file /usr/share/ca-certificates/CA_CERT
fi

service apache2 start

#TODO use ENV variables
PROXY_SETTINGS="-Dhttp.proxyHost=mitmproxy -Dhttp.proxyPort=8080 -Dhttps.proxyHost=mitmproxy -Dhttps.proxyPort=8080"

su jboss -s /bin/bash -c "/opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0 --debug 0.0.0.0:8787 $PROXY_SETTINGS"
