FROM mitmproxy/mitmproxy:6.0.2

# Based on artemkloko/docker-mitm-nginx-proxy-companion

# Because forego requires bash
RUN apk add --no-cache bash dnsmasq

# Install Forego, copied from https://dl.equinox.io/ddollar/forego/stable
RUN wget --quiet https://bin.equinox.io/c/ekMN3bCZFUn/forego-stable-linux-amd64.tgz && \
    tar xvf forego-stable-linux-amd64.tgz -C /usr/local/bin && \
    rm forego-stable-linux-amd64.tgz && \
    chmod u+x /usr/local/bin/forego

# Install docker-gen, copied from https://github.com/jwilder/nginx-proxy/blob/master/Dockerfile.alpine
ENV DOCKER_GEN_VERSION 0.7.4
RUN wget --quiet https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-alpine-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && tar -C /usr/local/bin -xvzf docker-gen-alpine-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && rm /docker-gen-alpine-linux-amd64-$DOCKER_GEN_VERSION.tar.gz

COPY docker-entrypoint.sh /usr/local/bin/

ADD config/dnsmasq.tmpl /etc/dnsmasq.tmpl
ADD config/dnsmasq-reload /usr/local/bin/dnsmasq-reload

ENV CA_DIR ""
ENV CA_CERT ""
ENV CA_KEY ""

ENV HOME "/home/mitmproxy/"
ENV MITMPROXY_PATH "/home/mitmproxy/.mitmproxy"

EXPOSE 53/udp
EXPOSE 8042

WORKDIR "$HOME"
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
