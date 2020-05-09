FROM maven:3.6.3-jdk-8-slim as builder
# based on https://github.com/ghchinoy/mitreidconnect-docker

ARG BUILD_HOME=/opt/mitreidc

# default to 1.3.x (latest stable);  master is the development branch.
# Override from docker build --build-arg if you want.
ARG BRANCH=1.3.x
ARG ISSUER=localhost:8080

ARG SERVER_HOST=localhost:8080

# install needed packages
RUN apt-get update \
    && apt-get install -y \
        gettext-base \
        git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN	mkdir -p $BUILD_HOME
WORKDIR $BUILD_HOME

# fetch the source code using provided branch
RUN git clone --branch $BRANCH --single-branch https://github.com/mitreid-connect/OpenID-Connect-Java-Spring-Server.git .

# Get dependencies
RUN mvn dependency:go-offline
# compile
RUN mvn -Dmaven.javadoc.skip=true -Dmaven.test.skip=true clean package

COPY ./config/WEB-INF ./WEB-INF
RUN envsubst < WEB-INF/server-config-template.xml > WEB-INF/server-config.xml

RUN jar uf openid-connect-server-webapp/target/openid-connect-server-webapp.war \
    WEB-INF/server-config.xml \
    WEB-INF/classes/db/hsql/users.sql \
    WEB-INF/classes/db/hsql/clients.sql

#####################################
#
FROM openjdk:8-jre-slim

RUN apt-get update && apt-get install -y \
    apache2 \
    curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install wildfly
ENV WILDFLY_VERSION="16.0.0.Final"
ENV JBOSS_HOME="/opt/jboss/wildfly"

RUN groupadd -r jboss \
    && useradd -r -g jboss -m -d /opt/jboss -s /sbin/nologin -c "JBoss user" jboss

USER jboss
WORKDIR /opt/jboss/

RUN curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
    && tar xf wildfly-$WILDFLY_VERSION.tar.gz \
    && mkdir -p $JBOSS_HOME \
    && mv wildfly-$WILDFLY_VERSION/* $JBOSS_HOME \
    && rm -r wildfly-$WILDFLY_VERSION.tar.gz  wildfly-$WILDFLY_VERSION

ENV TARGET_WAR /opt/jboss/wildfly/standalone/deployments/oidc-server.war

# deploy compiled war to wildfly container
COPY --from=builder --chown=jboss:jboss \
    /opt/mitreidc/openid-connect-server-webapp/target/openid-connect-server-webapp.war \
    /opt/jboss/wildfly/standalone/deployments/oidc-server.war

ARG SERVER_HOST

## add a safeguard file that contains Professos' controller domain
ARG CONTROLLER_URL
RUN mkdir -p /opt/jboss/wildfly/static/
RUN echo "https://$CONTROLLER_URL" > /opt/jboss/wildfly/static/static-professos.txt
## use a config that serves the static safeguard file
COPY --chown=jboss:jboss ./config/standalone.xml /opt/jboss/wildfly/standalone/configuration/standalone.xml

###
# deploy certs
ARG CA_DIR="/certs"
ARG CA_CERT="oidc-ca.crt"
VOLUME ["$CA_DIR"]

USER root
###
# apache
COPY config/mitreid.conf /etc/apache2/sites-available/
RUN sed -i "s#SERVER_HOST#$SERVER_HOST#g" /etc/apache2/sites-available/mitreid.conf
RUN a2enmod rewrite proxy_http headers ssl
RUN a2dissite 000-default
RUN a2ensite mitreid

EXPOSE 80
EXPOSE 443

COPY docker-entrypoint.sh /docker-entrypoint.sh

CMD ["/docker-entrypoint.sh"]
