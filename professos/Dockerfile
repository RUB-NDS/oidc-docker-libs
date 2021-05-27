#
# Build stage
#
FROM maven:3.6.3-jdk-11 AS build

ARG gitbranch
ARG GITHUB_TOKEN

RUN git clone -b $gitbranch https://github.com/RUB-NDS/PrOfESSOS.git /professos
RUN mkdir -p /home/app
RUN cp -R /professos/* /home/app/
RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM openjdk:11-jre-slim

#ARG CHROMEDRIVER_VERSION=79.0.3945.36
#ARG CHROMEDRIVER_VERSION=LATEST_RELEASE_81
ARG WILDFLY_VERSION=18.0.0.Final

USER root

###
# install packages
RUN apt-get update && apt-get install -y \
    apache2 \
    curl \
    wget \
    gnupg2 \
    vim \
    unzip \
    libglib2.0-0 \
    libnss3 \
    git \
    libfontconfig \
    iputils-ping \
    dnsutils \
    strace \
    chromium \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

###
# install chromedriver
RUN CHROMEDRIVER_VERSION=$(dpkg -s chromium | grep ^Version: | cut -d " " -f2 | cut -d "." -f1) \
 && CHROMEDRIVER_DL=$(echo $(curl -o - --silent https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${CHROMEDRIVER_VERSION})) \
 && curl -L -O https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_DL}/chromedriver_linux64.zip \
 && mkdir -p /opt/bin/ \
 && unzip chromedriver_linux64.zip -d /opt/bin/ \
 && rm -f chromedriver_linux64.zip \
 && ln -s /opt/bin/chromedriver /usr/bin/chromedriver

###
# setup wildfly as per https://github.com/jboss-dockerfiles/wildfly/blob/master/Dockerfile
RUN groupadd -r jboss -g 1000 \
    && useradd -u 1000 -r -g jboss -m -d /opt/jboss -s /sbin/nologin -c "JBoss user" jboss \
    && chmod 755 /opt/jboss

# Set the working directory to jboss' user home directory
WORKDIR /opt/jboss

ENV JBOSS_HOME /opt/jboss/wildfly

RUN cd $HOME \
    && curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
    && tar xf wildfly-$WILDFLY_VERSION.tar.gz \
    && mv $HOME/wildfly-$WILDFLY_VERSION $JBOSS_HOME \
    && rm wildfly-$WILDFLY_VERSION.tar.gz \
    && chown -R jboss:0 ${JBOSS_HOME} \
    && chmod -R g+rw ${JBOSS_HOME}

# Ensure signals are forwarded to the JVM process correctly for graceful shutdown
ENV LAUNCH_JBOSS_IN_BACKGROUND true

###
# Install and configure professos
ARG CONTROLLER_HOST
ARG HONEST_OP_HOST
ARG EVIL_OP_HOST
ARG HONEST_RP_HOST
ARG EVIL_RP_HOST
ARG TEST_RP_HOST
ARG TEST_OP_HOST
# optional
ARG SKIP_TARGET_GRANT="false"
ARG DISABLE_TLS_TRUST_CHECK="false"
ARG PRINT_TEST_ID_PATH="true"
ARG TEST_ID_LENGTH=8
ARG OPIV_ALLOW_CUSTOM_TEST_ID="true"

USER jboss
# add wildfly config (enables proxy-address-forwarding in default http listener; required when Wildfly runs
# behind a TLS terminating reverse proxy)
COPY --chown=jboss:jboss ./config/standalone.xml /opt/jboss/wildfly/standalone/configuration/standalone.xml
COPY --chown=jboss:jboss ./config/professos.conf /opt/jboss/professos-template.conf
RUN perl -p -e 's/\$\{(\w+)\}/(exists $ENV{$1}?$ENV{$1}:"missing variable $1")/eg' < /opt/jboss/professos-template.conf > /opt/jboss/professos.conf

COPY --chown=jboss:jboss --from=build /home/app/target/professos-1.0.0-SNAPSHOT.war ${JBOSS_HOME}/standalone/deployments/

# if you need to acces the management interface
RUN /opt/jboss/wildfly/bin/add-user.sh admin admin --silent
EXPOSE 9990

USER root

###
# deploy certs
ARG CA_DIR="/certs"
ARG CA_CERT
VOLUME ["$CA_DIR"]

###
# apache
COPY config/templates/* /etc/apache2/sites-available/
RUN sed -i "s#CONTROLLER_HOST#$CONTROLLER_HOST#g" /etc/apache2/sites-available/controller.conf && \
    sed -i "s#HONEST_OP_HOST#$HONEST_OP_HOST#g" /etc/apache2/sites-available/honest_op.conf && \
    sed -i "s#HONEST_RP_HOST#$HONEST_RP_HOST#g" /etc/apache2/sites-available/honest_rp.conf && \
    sed -i "s#EVIL_OP_HOST#$EVIL_OP_HOST#g" /etc/apache2/sites-available/evil_op.conf && \
    sed -i "s#EVIL_RP_HOST#$EVIL_RP_HOST#g" /etc/apache2/sites-available/evil_rp.conf

RUN a2enmod rewrite proxy_http headers ssl
RUN a2dissite 000-default
RUN a2ensite controller honest_op evil_op honest_rp evil_rp

###
# Run

# Expose the ports we're interested in
EXPOSE 8080
# port 8787 for debugging WildFly
EXPOSE 8787


COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
