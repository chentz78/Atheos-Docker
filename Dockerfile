FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive

MAINTAINER Liam Siira <liam@siira.io>
LABEL Description="Web-based cloud IDE with minimal footprint and requirements. " \
	Usage="docker run -d -p [HOST WWW PORT NUMBER]:80 hlsiira:latest" \
	Version="1.0"

RUN apt-get update -y
RUN apt -y install software-properties-common
RUN add-apt-repository ppa:ondrej/php

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y zip unzip

RUN apt install -y php7.4 php7.4-mbstring php7.4-zip && apt install -y git apache2 libapache2-mod-php7.4

RUN rm /var/www/html/*
RUN git clone https://github.com/Atheos/Atheos /tmp/Atheos
RUN mv /tmp/Atheos/* /var/www/html/

RUN a2enmod rewrite && chown -R www-data:www-data /var/www/html

VOLUME /var/www/html
VOLUME /etc/apache2

CMD ["apachectl","-D","FOREGROUND"]

EXPOSE 80
EXPOSE 443
