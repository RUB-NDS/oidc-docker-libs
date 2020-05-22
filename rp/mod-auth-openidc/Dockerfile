FROM debian:buster-slim

ENV OPENIDC_VERSION 2.4.2.1
ENV OPENIDC_VERSION_DEB_URL https://github.com/zmartzone/mod_auth_openidc/releases/download/v${OPENIDC_VERSION}/libapache2-mod-auth-openidc_${OPENIDC_VERSION}-1.buster+1_amd64.deb
ENV OPENIDC_VERSION_DEB_SHA1 3a23acded026a39c52bda05792efe5a18d65ab09

ENV CJOSE_VERSION 0.6.1.5
ENV CJOSE_DEB_URL https://github.com/zmartzone/mod_auth_openidc/releases/download/v2.4.0/libcjose0_${CJOSE_VERSION}-1.buster+1_amd64.deb
ENV CJOSE_DEB_SHA1 d6ca5569bed04a1450e054b3280702f1edfe2ae7

ARG CONTROLLER_URL
ARG CLIENT_HOST

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       apache2 \
       libcurl4 \
       ca-certificates \
       curl \
       libpcre3 \
       libjansson4 \
       libhiredis0.14 \
       php7.3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

RUN curl -sLSf "$CJOSE_DEB_URL" -o libcjose.deb \
  && echo "$CJOSE_DEB_SHA1 libcjose.deb" | sha1sum -c - \
  && dpkg -i libcjose.deb \
  && rm libcjose.deb

RUN curl -sLSf "$OPENIDC_VERSION_DEB_URL" -o mod_auth_openidc-$OPENIDC_VERSION.deb \
  && echo "$OPENIDC_VERSION_DEB_SHA1 mod_auth_openidc-$OPENIDC_VERSION.deb" | sha1sum -c - \
  && (dpkg -i mod_auth_openidc-$OPENIDC_VERSION.deb || echo "Accepting missing dependency") \
  && dpkg --force-all -i mod_auth_openidc-$OPENIDC_VERSION.deb \
  && rm mod_auth_openidc-$OPENIDC_VERSION.deb

RUN chown -R www-data: /var/www/html
USER www-data

COPY html/ /var/www/html/

# Allow professos
RUN echo "https://$CONTROLLER_URL" > /var/www/html/.professos

USER root

# NGINX config
ARG CA_DIR="/certs"
ARG CA_CERT="oidc-ca.crt"
VOLUME ["$CA_DIR"]

ENV APACHE_CONFDIR=/etc/apache2
ENV APACHE_ENVVARS=/etc/apache2/envvars

COPY config/server.conf /etc/apache2/sites-available/
RUN sed -i "s#CLIENT_HOST#$CLIENT_HOST#g" /etc/apache2/sites-available/server.conf

RUN a2enmod rewrite proxy_http headers ssl auth_openidc
RUN a2dissite 000-default
RUN a2ensite server

EXPOSE 80
EXPOSE 443

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
