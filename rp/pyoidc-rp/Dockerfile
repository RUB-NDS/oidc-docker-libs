FROM python:3.7.7-slim-buster

ARG BRANCH=master
ARG CONTROLLER_URL
ARG CLIENT_HOST
ARG ISSUER

RUN apt-get update \
    && apt-get install -y  --no-install-recommends \
       nginx \
       curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY app/requirements.txt /app/
WORKDIR /app

RUN pip install -r requirements.txt

COPY config/provider_configuration.py /usr/local/lib/python3.7/site-packages/flask_pyoidc/

COPY app /app
COPY config/provider.json /app/

RUN sed -i "s#ISSUER#$ISSUER#g" /app/provider.json

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
