FROM ubuntu:14.04

RUN apt-get update; apt-get install -y apache2  wget # less vim telnet tcpdump 
RUN apt-get install -y php5 php-mdb2 php-mdb2-driver-mysql php5-mcrypt php5-curl php-pear; php5enmod mcrypt 

RUN pear channel-discover phpseclib.sourceforge.net && pear channel-update pear.php.net

RUN pear install phpseclib/Crypt_AES; pear install phpseclib/Crypt_Blowfish; pear install phpseclib/Crypt_DES; pear install phpseclib/Crypt_Hash; pear install phpseclib/Crypt_RC4; pear install phpseclib/Crypt_RSA; pear install phpseclib/Crypt_TripleDES; pear install phpseclib/Crypt_Twofish; pear install phpseclib/File_ANSI; pear install phpseclib/File_ASN1; pear install phpseclib/File_X509; pear install phpseclib/Net_SCP; pear install phpseclib/Net_SFTP; pear install phpseclib/Net_SSH1; pear install phpseclib/System_SSH_Agent

RUN wget https://bitbucket.org/PEOFIAMP/phpoidc/get/default.tar.gz && \
  tar -xzf default.tar.gz && \
  mv PEOFIAMP-phpoidc-c7a759a75afa/phpOp /var/www/html/ && \
  mv PEOFIAMP-phpoidc-c7a759a75afa/phpRp /var/www/html/ && \
  echo 'http://openid.sso-security.de:8080' > /var/www/html/.professos && \
  chown www-data:www-data -R /var/www/html && \
  rm -rf PEOFIAMP-phpoidc-c7a759a75afa

COPY ./conf/000-default.conf /etc/apache2/sites-available/
COPY ./conf/dbconf.php /var/www/html/phpOp/
COPY ./conf/dbconf.php /var/www/html/phpRp/
COPY ./conf/abconstants.php /var/www/html/phpOp/abconstants.php
COPY ./conf/abconstants.php /var/www/html/phpRp/abconstants.php
# fixed error in content type detection :/
COPY ./conf/index.php /var/www/html/phpOp/index.php

# Doctrine appears to be no longer available via pear. Disable in pear script to complete the build
RUN sed -i -E 's/^(package_add "pear.doctrine-project.org" Doctrine)$/#\1/' /var/www/html/phpOp/checkPearDependencies.sh && \
  pear channel-update pear.php.net && \
  /var/www/html/phpOp/checkPearDependencies.sh

# manually download, extract and place Doctrine directly in phppOIDC folders
RUN cd /tmp/ && wget https://github.com/doctrine/doctrine1/archive/1.2.4.tar.gz && tar xzf 1.2.4.tar.gz && cp -r doctrine1-1.2.4/lib/* /var/www/html/phpOp/ && cp -r doctrine1-1.2.4/lib/* /var/www/html/phpRp/ && chown www-data:www-data -R /var/www/html 

CMD ["apachectl", "-D", "FOREGROUND"]
