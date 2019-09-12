FROM c2id/c2id-server:7.8

USER root
WORKDIR /opt/

RUN apt-get update && apt-get install -y vim tcpdump less maven git sed && \
  git clone https://bitbucket.org/connect2id/connect2id-login-page-js.git && \
  mvn -f ./connect2id-login-page-js/pom.xml clean package && \
  sed -i 's|127.0.0.1:8080|honest-idp.com:8080|g' ./connect2id-login-page-js/src/main/webapp/js/main.js && \
  mvn -f ./connect2id-login-page-js/pom.xml clean package && \
  mv /opt/connect2id-login-page-js/target/c2id-login-page-js.war /c2id-server/tomcat/webapps/ && \ 
  mvn -f ./connect2id-login-page-js/pom.xml clean 
# RUN apt-get autoremove --purge -y git maven && apt-get clean

RUN mkdir /var/www/ && echo 'http://openid.sso-security.de:8080' > /var/www/.professos && chown -R www-data:www-data /var/www

COPY ./conf/tomcat-server.xml /c2id-server/tomcat/conf/server.xml

EXPOSE 8080

