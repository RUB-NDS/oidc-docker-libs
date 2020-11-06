FROM php:7.4-fpm

ARG BRANCH
ARG HASH=822d9c4
ARG CONTROLLER_URL
ARG SERVER_HOST

RUN apt-get update \
    && apt-get install -y \
       git \
       nginx \
    && docker-php-ext-install pdo pdo_mysql \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pear channel-discover phpseclib.sourceforge.net \
    && pear install phpseclib/Crypt_AES \
    && pear install phpseclib/Crypt_DES \
    && pear install phpseclib/Crypt_Hash \
    && pear install phpseclib/Crypt_RC4 \
    && pear install phpseclib/Crypt_RSA \
    && pear install phpseclib/Crypt_TripleDES \
    && pear install phpseclib/File_ANSI \
    && pear install phpseclib/File_ASN1 \
    && pear install phpseclib/File_X509

WORKDIR /var/www/
RUN cd /tmp/ \
    && git clone -b $BRANCH https://bitbucket.org/PEOFIAMP/phpoidc/
WORKDIR /tmp/phpoidc/
RUN git reset --hard $HASH
COPY config/*.php /tmp/phpoidc/phpOp/

RUN mv /tmp/phpoidc/phpOp /var/www/ \
    && chown -R www-data: /var/www/phpOp \
    && rm -rf /tmp/phpoidc

RUN echo "https://$CONTROLLER_URL" > /var/www/phpOp/.professos

# use server url from docker name
RUN sed -i "s#PHPOP_SERVER_NAME#$SERVER_HOST#g" /var/www/phpOp/abconstants.php
# set session path to /tmp
RUN sed -i "s#session_save_path()#$session_save_path('/tmp')#g" /var/www/phpOp/index.php

ARG CA_DIR="/certs"
ARG CA_CERT="oidc-ca.crt"
VOLUME ["$CA_DIR"]

COPY ./config/server.conf /etc/nginx/sites-enabled/
RUN rm -f /etc/nginx/sites-enabled/default \
    && sed -i "s#SERVER_HOST#$SERVER_HOST#g" /etc/nginx/sites-enabled/server.conf

RUN sed -i '/gzip on;/a fastcgi_buffer_size 32k;' /etc/nginx/nginx.conf \
 && sed -i '/gzip on;/a fastcgi_buffers 8 16k;' /etc/nginx/nginx.conf

RUN echo 'fastcgi_param   SCRIPT_FILENAME         $document_root$fastcgi_script_name;' >> /etc/nginx/fastcgi_params
RUN echo 'fastcgi_param   PATH_INFO               $fastcgi_path_info;' >> /etc/nginx/fastcgi_params

EXPOSE 80
EXPOSE 443

COPY docker-entrypoint.sh /docker-entrypoint.sh

CMD ["/docker-entrypoint.sh"]
