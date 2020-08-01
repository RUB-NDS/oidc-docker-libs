FROM python:3.7.7-slim-buster

ARG BRANCH=master
ARG HASH=17ab0e45853681d4333ae3e16b311a8936780cab
ARG CONTROLLER_URL
ARG CLIENT_HOST
ARG ISSUER
ARG ISSUER2

RUN apt-get update \
    && apt-get install -y  --no-install-recommends \
       git \
       nginx \
       curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/local/src
RUN git clone --branch=$BRANCH https://github.com/IdentityPython/JWTConnect-Python-OidcRP.git \
    && cd JWTConnect-Python-OidcRP \
    && git reset --hard $HASH

COPY patches/001-user-needle.patch JWTConnect-Python-OidcRP/
RUN cd JWTConnect-Python-OidcRP \
    && git apply 001-user-needle.patch

COPY config/requirements.txt /app/
WORKDIR /app

RUN mv /usr/local/src/JWTConnect-Python-OidcRP/flask_rp/* . \
    && rm -rf /usr/local/src/*

RUN pip install -r requirements.txt

COPY config/conf.yaml /app/
RUN sed -i "s#HONESTSERVER#$ISSUER#g" /app/conf.yaml
RUN sed -i "s#EVILSERVER#$ISSUER2#g" /app/conf.yaml
RUN sed -i "s#CLIENT_HOST#$CLIENT_HOST#g" /app/conf.yaml

# Allow professos
RUN echo "https://$CONTROLLER_URL" > /var/www/html/.professos

# NGINX config
ARG CA_DIR="/certs"
ARG CA_CERT="oidc-ca.crt"
VOLUME ["$CA_DIR"]

# workaround for cherrypy to have certificate in relative path
RUN mkdir -p /app/certs \
    && ln -s /certs/${CLIENT_HOST}/${CLIENT_HOST}.crt certs/${CLIENT_HOST}.crt \
    && ln -s /certs/${CLIENT_HOST}/${CLIENT_HOST}.key certs/${CLIENT_HOST}.key

COPY ./config/server.conf /etc/nginx/sites-enabled/
RUN rm -f /etc/nginx/sites-enabled/default \
    && sed -i "s#CLIENT_HOST#$CLIENT_HOST#g" /etc/nginx/sites-enabled/server.conf

EXPOSE 80
EXPOSE 443

COPY docker-entrypoint.sh /docker-entrypoint.sh

CMD ["/docker-entrypoint.sh"]
