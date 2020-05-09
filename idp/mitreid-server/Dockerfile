FROM maven:3-jdk-8 as builder
# based on https://github.com/ghchinoy/mitreidconnect-docker

ARG HOME=/opt/mitreidc

# default to 1.3.x (latest stable);  master is the development branch.
# Override from docker build --build-arg if you want.
ARG BRANCH=1.3.x
ARG ISSUER=localhost:8080

RUN	mkdir -p $HOME
WORKDIR $HOME

# fetch the source code using provided branch
RUN git clone --branch $BRANCH --single-branch https://github.com/mitreid-connect/OpenID-Connect-Java-Spring-Server.git .

# compile
RUN mvn -Dmaven.javadoc.skip=true -Dmaven.test.skip=true clean package

#####################################
#
FROM openjdk:8-jdk

RUN apt-get update && apt-get install -y \
    apache2 \
    git \
    zip \
    curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install wildfly
ENV WILDFLY_VERSION="16.0.0.Final"
ENV JBOSS_HOME="/opt/jboss/wildfly"

RUN groupadd -r jboss  && useradd -r -g jboss -m -d /opt/jboss -s /sbin/nologin -c "JBoss user" jboss

RUN curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
    && tar xf wildfly-$WILDFLY_VERSION.tar.gz \
    && mkdir -p $JBOSS_HOME \
    && mv wildfly-$WILDFLY_VERSION/* $JBOSS_HOME \
    && chown -R jboss:0 ${JBOSS_HOME} \
    && chmod -R g+rw ${JBOSS_HOME} \
    && rm -r wildfly-$WILDFLY_VERSION.tar.gz  wildfly-$WILDFLY_VERSION

ENV HOME /opt/mitreidc
ENV TARGET_WAR /opt/jboss/wildfly/standalone/deployments/oidc-server.war

USER root
# deploy compiled war to wildfly container
COPY --from=builder $HOME/openid-connect-server-webapp/target/openid-connect-server-webapp.war $TARGET_WAR

# update config in .war, so we dont need to recompile when changing configs
ARG MITREID_SERVER_HOST
WORKDIR $HOME
COPY ./config/WEB-INF ./WEB-INF
RUN perl -p -e 's/\$\{(\w+)\}/(exists $ENV{$1}?$ENV{$1}:"missing variable $1")/eg' < WEB-INF/server-config-template.xml > WEB-INF/server-config.xml

RUN jar uf $TARGET_WAR WEB-INF/server-config.xml \
                        WEB-INF/classes/db/hsql/users.sql \
                        WEB-INF/classes/db/hsql/clients.sql

## add a safeguard file that contains Professos' controller domain
ARG CONTROLLER_URL
RUN mkdir -p /opt/jboss/wildfly/static/
RUN echo "https://$CONTROLLER_URL" > /opt/jboss/wildfly/static/static-professos.txt
## use a config that serves the static safeguard file
COPY ./config/standalone.xml /opt/jboss/wildfly/standalone/configuration/standalone.xml
USER root
RUN chown jboss:jboss -R /opt/jboss/wildfly/static/static-professos.txt && \
    chown jboss:jboss -R /opt/jboss/wildfly/standalone/configuration/standalone.xml

###
# deploy certs
ARG CA_DIR="/certs"
ARG CA_CERT="oidc-ca.crt"
VOLUME ["$CA_DIR"]

###
# apache
COPY config/mitreid.conf /etc/apache2/sites-available/
RUN sed -i "s#MITREID_SERVER_HOST#$MITREID_SERVER_HOST#g" /etc/apache2/sites-available/mitreid.conf
RUN a2enmod rewrite proxy_http headers ssl
RUN a2dissite 000-default
RUN a2ensite mitreid

EXPOSE 8080

# uncomment below, if you need to access the management interface
# EXPOSE 9990
# RUN /opt/jboss/wildfly/bin/add-user.sh admin Admin#70365 --silent

# Set the default command to run on boot
# This will boot WildFly in the standalone mode and bind to all interfaces
COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

# build with: "sudo docker build -t mitreid-server-webapp:latest ."
# run with: "sudo docker run -ti -p 8080:8080 mitreid-server-webapp:latest"
#
# To set the Issuer ID to 'honestidp:8080', build with:
# "sudo docker build --build-arg ISSUER=honestidp.de:8080 -t mitreid-server-webapp:latest ."
# Configuration can then still be found at localhost:8080/openid-connect-server-webapp/.well-known/openid-configuration
# even though the IdP uses honestidp.de:8080 as issuer URI, so relative links will be broken.
# You may want to add honestidp.de to /etc/hosts as a WA
