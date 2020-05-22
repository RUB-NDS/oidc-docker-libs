FROM python:3.7.7-slim-buster

ARG BRANCH=master
ARG CONTROLLER_URL
ARG CLIENT_HOST

RUN apt-get update \
    && apt-get install -y \
       nginx \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY simple-rp/requirements.txt /app/
WORKDIR /app

RUN pip install -r requirements.txt

COPY simple-rp /app

RUN sed -i "s#CLIENT_HOST#$CLIENT_HOST#g" /app/settings.yaml

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
