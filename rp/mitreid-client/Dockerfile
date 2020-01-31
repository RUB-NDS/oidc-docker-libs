FROM maven:3-jdk-8 as builder

ENV HOME /opt/mitreidc-sp

# Override from docker build --build-arg if you want.
ARG BRANCH=master

RUN apt-get update && apt-get upgrade -y && apt-get install -y git wget sudo && apt-get clean && \
        mkdir -p $HOME

# Install
WORKDIR $HOME

# fetch the source code using provided branch
RUN git clone --branch $BRANCH https://github.com/mitreid-connect/simple-web-app.git .

# update config
#COPY ./config/servlet-context.xml $HOME/src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml

# compile simple-web-app without generating doc and tests
RUN mvn -Dmaven.javadoc.skip=true -Dmaven.test.skip=true clean package

#####

FROM openjdk:8-jre

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

ENV HOME /opt/mitreidc-sp

# copy demo client to deployment folder
COPY --from=builder $HOME/target/simple-web-app.war /opt/jboss/wildfly/standalone/deployments/simple-web-app.war

# update config in .war, so we dont need to recompile when updating config
COPY ./config/servlet-context-template.xml ./servlet-context-template.xml
RUN mkdir -p WEB-INF/spring/appServlet/
RUN perl -p -e 's/\$\{(\w+)\}/(exists $ENV{$1}?$ENV{$1}:"missing variable $1")/eg' < ./servlet-context-template.xml > WEB-INF/spring/appServlet/servlet-context.xml

RUN zip -ur /opt/jboss/wildfly/standalone/deployments/simple-web-app.war WEB-INF/spring/appServlet/servlet-context.xml

## add a safeguard file that contains controller domain
ARG CONTROLLER_URL
RUN mkdir -p /opt/jboss/wildfly/static/
RUN echo "https://$CONTROLLER_URL" > /opt/jboss/wildfly/static/static-professos.txt
RUN chown jboss:jboss -R /opt/jboss/wildfly/static/static-professos.txt
# add wildfly config that serves the static safeguard file
COPY ./config/standalone.xml /opt/jboss/wildfly/standalone/configuration/standalone.xml

###
# deploy certs
ARG CA_DIR="/certs"
ARG CA_CERT="oidc-ca.crt"
ARG MITREID_CLIENT_HOST
VOLUME ["$CA_DIR"]

###
# apache
COPY config/mitreid.conf /etc/apache2/sites-available/
RUN sed -i "s#MITREID_CLIENT_HOST#$MITREID_CLIENT_HOST#g" /etc/apache2/sites-available/mitreid.conf
RUN a2enmod rewrite proxy_http headers ssl
RUN a2dissite 000-default
RUN a2ensite mitreid

# Expose the ports we're interested in
EXPOSE 8080

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN sed -i "s#CA_DIR#$CA_DIR#g" /docker-entrypoint.sh && \
    sed -i "s#CA_CERT#$CA_CERT#g" /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
