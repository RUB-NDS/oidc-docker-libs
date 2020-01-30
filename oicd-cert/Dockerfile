FROM alpine

ENV CA_DIR "/certs"
ENV CA_CERT oicd-ca.crt
ENV CA_KEY oicd-ca.key
ENV CA_EXPIRE 3650
ENV SSL_KEY_SIZE 2048

# install openssl
RUN apk add --update openssl bash && \
    rm -rf /var/cache/apk/*

COPY docker-entrypoint.sh /

VOLUME ["$CA_DIR"]
ENTRYPOINT ["/docker-entrypoint.sh"]