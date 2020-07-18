FROM ubuntu:18.04

ARG BRANCH=master
ARG HASH=7f4819b7107b069b50bb1b2f2ff2acb5e296c2d9
ARG CONTROLLER_URL
ARG ISSUER
ARG CLIENT_HOST

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    git \
    gnupg \
    ntp \
    wget
RUN wget -q https://deb.nodesource.com/setup_12.x -O - | bash -
RUN apt-get update && apt-get install -y --no-install-recommends \
    apache2 \
    nodejs && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV SRCDIR /usr/local/src
ENV INSTDIR auth0-express-webapp-sample/01-Login
ENV SUBDIR ${SRCDIR}/${INSTDIR}

WORKDIR ${SRCDIR}
RUN git clone --branch=$BRANCH https://github.com/auth0-samples/auth0-express-webapp-sample.git
WORKDIR ${INSTDIR}
RUN git reset --hard $HASH
# remove unwanted package-lock checkin
RUN rm -f package-lock.json
RUN npm install

COPY config/env* ./
COPY config/server.js server.js


RUN if [ -z "$ISSUER" ]; then cp env .env; else cp env.prof .env; sed -i "s#ISSUER_URL#$ISSUER#g" .env; fi
RUN sed -i "s#CLIENT_HOST#$CLIENT_HOST#g" .env

###
# deploy certs
ARG CA_DIR="/certs"
ARG CA_CERT="oidc-ca.crt"
VOLUME ["$CA_DIR"]

COPY config/apache-ssl.conf /etc/apache2/sites-available/ssl.conf

RUN sed -i "s#CLIENT_HOST#$CLIENT_HOST#g" /etc/apache2/sites-available/ssl.conf

RUN a2enmod headers ssl proxy proxy_http rewrite
RUN a2ensite ssl

RUN echo "https://$CONTROLLER_URL" > /var/www/html/.professos

COPY docker-entrypoint.sh ${SUBDIR}/

WORKDIR ${SUBDIR}
ENTRYPOINT ["./docker-entrypoint.sh"]
