FROM ubuntu:18.04

ARG CONTROLLER_URL
ARG SERVER_HOST

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
ENV INSTDIR node-oidc-provider
ENV SUBDIR ${SRCDIR}/${INSTDIR}

WORKDIR ${SRCDIR}
RUN git clone --depth=1 --branch=v6.17.3 https://github.com/panva/node-oidc-provider.git
WORKDIR ${INSTDIR}
RUN npm install


###
# deploy certs
ARG CA_DIR="/certs"
ARG CA_CERT="oidc-ca.crt"
VOLUME ["$CA_DIR"]

COPY apache-ssl.conf /etc/apache2/sites-available/ssl.conf

RUN sed -i "s#SERVER_HOST#$SERVER_HOST#g" /etc/apache2/sites-available/ssl.conf

RUN a2enmod headers ssl proxy proxy_http rewrite
RUN a2ensite ssl

RUN echo "https://$CONTROLLER_URL" > /var/www/html/.professos

COPY run.sh ${SUBDIR}/

WORKDIR ${SUBDIR}
ENTRYPOINT ["./run.sh"]
