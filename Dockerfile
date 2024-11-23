FROM bitnami/minideb:bullseye

ENV TZ="America/Fortaleza"

ENV DEBIAN_FRONTEND=noninteractive

RUN echo 'APT::Install-Recommends "false";\nAPT::Install-Suggests "false";' >> /etc/apt/apt.conf

MAINTAINER Liam Siira <liam@siira.io>
LABEL Description="Web-based cloud IDE with minimal footprint and requirements. " \
	Usage="docker run -d -p [HOST WWW PORT NUMBER]:80 hlsiira:latest" \
	Version="1.0"

RUN apt update -y && apt upgrade -y

RUN apt install -y apt-utils openssl curl zip unzip

RUN apt install -y git apache2

RUN apt install -y php

RUN apt install -y php-zip php-mbstring libapache2-mod-php

#Install Python
RUN apt install -y build-essential python3

RUN apt clean && rm -rf /var/lib/apt/lists/*

RUN rm /var/www/html/*
#Error "server certificate verification failed. CAfile: none CRLfile: none" from https://gist.github.com/rponte/e2524e319cd4d17f9072a3347b1a6aaa
RUN git config --global http.sslVerify false
RUN git clone https://github.com/Atheos/Atheos /tmp/Atheos
RUN mv /tmp/Atheos/* /var/www/html/

RUN a2enmod rewrite && chown -R www-data:www-data /var/www/html

VOLUME /var/www/html
VOLUME /etc/apache2

CMD ["apachectl","-D","FOREGROUND"]

EXPOSE 80
EXPOSE 443
