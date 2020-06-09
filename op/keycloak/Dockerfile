FROM jboss/keycloak:10.0.2

USER root

RUN microdnf update && \
    microdnf install -y httpd \
       mod_ssl && \
    microdnf clean all

ARG CONTROLLER_URL
ARG SERVER_HOST

RUN echo "https://$CONTROLLER_URL" > /var/www/static_professos
###
# deploy certs
ARG CA_DIR="/certs"
ARG CA_CERT="oidc-ca.crt"
VOLUME ["$CA_DIR"]

###
# httpd apache
COPY config/server.conf /etc/httpd/conf/httpd.conf
RUN sed -i "s#SERVER_HOST#$SERVER_HOST#g" /etc/httpd/conf/httpd.conf

EXPOSE 80
EXPOSE 443

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
