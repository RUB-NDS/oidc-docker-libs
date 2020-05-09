FROM alpine

ENV CA_DIR "/certs"
ENV CA_CERT oidc-ca.crt
ENV CA_KEY oidc-ca.key
ENV CA_EXPIRE 3650
ENV SSL_KEY_SIZE 2048

# install openssl
RUN apk add --update openssl bash \
    && rm -rf /var/cache/apk/*

# install docker gen
ARG DOCKER_GEN_VERSION=0.7.4

RUN wget https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
    && tar -C /usr/local/bin -xvzf docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
    && rm /docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz

ENV DOCKER_HOST unix:///tmp/docker.sock

COPY cert-gen /cert-gen
WORKDIR "/cert-gen"

VOLUME ["$CA_DIR"]

CMD ["/cert-gen/docker-entrypoint.sh"]
