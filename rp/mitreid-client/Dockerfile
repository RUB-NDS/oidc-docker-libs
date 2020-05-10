FROM maven:3.6.3-jdk-8-slim as builder

ARG BUILD_HOME=/opt/mitreidc
ARG BRANCH=master
ARG ISSUER
ARG CLIENT_HOST

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
RUN git clone --branch $BRANCH --single-branch https://github.com/mitreid-connect/simple-web-app.git .

# Get dependencies
RUN mvn dependency:go-offline

# static configuration
COPY ./config/servlet-context-template.xml ./src/main/webapp/WEB-INF/spring/appServlet/servlet-context-template.xml
RUN envsubst \
    < ./src/main/webapp/WEB-INF/spring/appServlet/servlet-context-template.xml \
    > ./src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml \
    && rm -f ./src/main/webapp/WEB-INF/spring/appServlet/servlet-context-template.xml

# compile simple-web-app without generating doc and tests
RUN mvn -Dmaven.javadoc.skip=true -Dmaven.test.skip=true clean package

########################################################################################################################
FROM openjdk:8-jre-slim

ARG CLIENT_HOST
ARG CONTROLLER_URL

RUN apt-get update \
    && apt-get install -y \
        apache2 \
        curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

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

# copy demo client to deployment folder
COPY --from=builder --chown=jboss:jboss \
    /opt/mitreidc/target/simple-web-app.war \
    /opt/jboss/wildfly/standalone/deployments/simple-web-app.war

## add a safeguard file that contains controller domain
RUN mkdir -p /opt/jboss/wildfly/static/
RUN echo "https://$CONTROLLER_URL" > /opt/jboss/wildfly/static/static-professos.txt
RUN chown jboss:jboss -R /opt/jboss/wildfly/static/static-professos.txt
# add wildfly config that serves the static safeguard file
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
RUN sed -i "s#CLIENT_HOST#$CLIENT_HOST#g" /etc/apache2/sites-available/mitreid.conf
RUN a2enmod rewrite proxy_http headers ssl
RUN a2dissite 000-default
RUN a2ensite mitreid

EXPOSE 80
EXPOSE 443

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
