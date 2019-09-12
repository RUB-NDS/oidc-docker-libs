FROM php:7.3.3-apache-stretch

RUN apt-get update && \
  apt-get install -y wget vim libhiredis0.13 libjansson4
RUN mkdir -p /var/cache/mod_auth_openidc/metadata/ && \
  chown www-data:www-data /var/cache/mod_auth_openidc/metadata && \
  mkdir -p /var/www/html/oidc/callback && \
  echo 'http://openid.sso-security.de:8080' > /var/www/html/.professos && \
  chown www-data:www-data -R /var/www/html && \
  apt-get clean

RUN wget https://github.com/zmartzone/mod_auth_openidc/releases/download/v2.3.11/libapache2-mod-auth-openidc_2.3.11-1.stretch+1_amd64.deb && \
  wget https://github.com/zmartzone/mod_auth_openidc/releases/download/v2.3.11/libcjose0_0.6.1.4-1.stretch+1_amd64.deb 

RUN dpkg -i libcjose0_0.6.1.4-1.stretch+1_amd64.deb && \
  dpkg -i libapache2-mod-auth-openidc_2.3.11-1.stretch+1_amd64.deb && \
  a2enmod auth_openidc

COPY ./conf/example.php /var/www/html/oidc/example.php
#COPY ./conf/cert/* /etc/apache2/ssl/
COPY ./conf/000-default.conf /etc/apache2/sites-available/000-default.conf

RUN service apache2 restart



  
