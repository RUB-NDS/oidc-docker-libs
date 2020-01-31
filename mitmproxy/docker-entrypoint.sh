#!/bin/sh
set -e

MITMPROXY_PATH="/home/mitmproxy/.mitmproxy"

mkdir -p "$MITMPROXY_PATH"
chown -R mitmproxy:mitmproxy "$MITMPROXY_PATH"
set -x
cat ${CA_DIR}/${CA_KEY} ${CA_DIR}/${CA_CERT} > ${MITMPROXY_PATH}/mitmproxy-ca.pem

RUN_CMD="mitmweb --web-iface 0.0.0.0 --set web_open_browser=false --ssl-insecure"

# The following part was modified to generate Procfile with the commands
# needed to run by forego
echo "mitmproxy: su-exec mitmproxy ${RUN_CMD}" > Procfile
echo "dnsmasq: docker-gen -watch -only-exposed -notify \"dnsmasq-reload -u root\" /etc/dnsmasq.tmpl /etc/dnsmasq.conf" >> Procfile
forego start -r
