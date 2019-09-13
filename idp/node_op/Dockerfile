# based on: https://github.com/rohe/oidctest/tree/master/docker/op

FROM ubuntu:18.04

RUN apt-get clean && apt-get --fix-missing update
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y git ntp curl
RUN apt-get update && apt-get install -y gnupg
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get update && apt-get install -y nodejs apache2

ENV SRCDIR /usr/local/src
ENV INSTDIR node-oidc-provider
ENV SUBDIR ${SRCDIR}/${INSTDIR}

WORKDIR ${SRCDIR}

COPY conf/apache-ssl.conf /etc/apache2/sites-available/ssl.conf
COPY conf/cert.pem /etc/apache2/
COPY conf/key.pem /etc/apache2/

RUN a2enmod headers && a2enmod ssl && a2enmod proxy && a2enmod proxy_http && a2ensite ssl


RUN git clone https://github.com/panva/node-oidc-provider.git

# could not get the example app in newer versions to work
ENV VERSION_NODE_OP   tags/v4.0.3
# v4.5 works, but code redemption fails randomly
#ENV VERSION_NODE_OP   tags/v4.5.0

RUN cd node-oidc-provider && git checkout ${VERSION_NODE_OP} && cd -
RUN cd ${INSTDIR} && npm install && cd -
COPY conf/run.sh ${SUBDIR}/

WORKDIR ${SUBDIR}
ENTRYPOINT ["./run.sh"]
