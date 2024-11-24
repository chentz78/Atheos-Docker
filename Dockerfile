FROM php:7.4.33-alpine3.15

MAINTAINER Liam Siira <liam@siira.io>
LABEL Description="Web-based cloud IDE with minimal footprint and requirements. " \
	Usage="docker run -d -p [HOST WWW PORT NUMBER]:80 hlsiira:latest" \
	Version="1.0"

RUN apk update

# Pull in nproc:
RUN apk add --no-cache coreutils openssl

RUN apk add --no-cache zip unzip git apache2 php-apache2

RUN apk add --no-cache php-mbstring php-zip php-session php-openssl php-phar php-json php-iconv

#RUN rm /var/www/localhost/htdocs/*

#Error "server certificate verification failed. CAfile: none CRLfile: none" from https://gist.github.com/rponte/e2524e319cd4d17f9072a3347b1a6aaa
RUN git config --global http.sslVerify false

ENV SL /var/www/localhost/htdocs

RUN git clone https://github.com/Atheos/Atheos /tmp/Atheos \
 && chown -R apache:apache /tmp/Atheos

RUN rm -rf ${SL}/* \
 && cp -av /tmp/Atheos/* ${SL}/ \
 && rm -rf /tmp/Atheos

RUN sed -i "s/#LoadModule\ rewrite_module/LoadModule\ rewrite_module/" /etc/apache2/httpd.conf \
 && sed -i "s/#LoadModule\ session_module/LoadModule\ session_module/" /etc/apache2/httpd.conf \
 && sed -i "s/#LoadModule\ session_cookie_module/LoadModule\ session_cookie_module/" /etc/apache2/httpd.conf \
 && sed -i "s/#LoadModule\ session_crypto_module/LoadModule\ session_crypto_module/" /etc/apache2/httpd.conf \
 && sed -i "s/#LoadModule\ deflate_module/LoadModule\ deflate_module/" /etc/apache2/httpd.conf \
 && printf "\n<Directory \"${SL}\">\n\tAllowOverride All\n</Directory>\n" >> /etc/apache2/httpd.conf

RUN chown apache:apache ${SL}

VOLUME ${SL}
VOLUME /etc/apache2

#Debug
RUN echo 'alias la="ls -lha --color"' >> ~/.ashrc \
 && echo 'alias lat="ls -lha --color -tr"' >> ~/.ashrc \
 && echo 'alias apFG="httpd -D FOREGROUND"' >> ~/.ashrc

CMD ["httpd","-D","FOREGROUND"]

EXPOSE 80
EXPOSE 443
