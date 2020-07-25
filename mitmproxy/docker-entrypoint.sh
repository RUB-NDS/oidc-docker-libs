#!/bin/sh
set -e

mkdir -p $MITMPROXY_PATH
chown mitmproxy:mitmproxy "$MITMPROXY_PATH"
cat ${CA_DIR}/${CA_KEY} ${CA_DIR}/${CA_CERT} > ${MITMPROXY_PATH}/mitmproxy-ca.pem

# for script examples https://github.com/mitmproxy/mitmproxy/tree/master/examples

set -x
RUN_CMD="mitmweb --web-iface 0.0.0.0 \
        --set web_open_browser=false --set stream_websockets=true \
        --ssl-insecure \
        --showhost \
        -s ${HOME}/scripts/enhancedProfessos.py"

# The following part was modified to generate Procfile with the commands
# needed to run by forego
echo "mitmproxy: su-exec mitmproxy ${RUN_CMD}" > Procfile
echo "dnsmasq: docker-gen -watch -only-exposed -notify \"dnsmasq-reload -u root\" /etc/dnsmasq.tmpl /etc/dnsmasq.conf" >> Procfile
forego start -r
