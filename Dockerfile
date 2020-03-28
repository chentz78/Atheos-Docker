FROM ubuntu:18.04
LABEL Liam Siira <liam@siira.us>


# Add To apt Repo
RUN apt-get update
RUN apt -y install software-properties-common
RUN add-apt-repository ppa:ondrej/php


#Setup tzdata
RUN export DEBIAN FRONTEND=noninteractive
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
RUN apt install -y tzdata
RUN dpkg-reconfigure --frontend noninteractive tzdata


# Required Packages
RUN apt-get update
RUN apt -y install software-properties-common
RUN add-apt-repository ppa:ondrej/php
RUN apt-get update

RUN apt install -y git apache2
RUN apt install -y php7.4 php7.4-mbstring php7.4-zip

RUN a2enmod php7.4

RUN service apache2 start

# Clone Atheos and put into the /default-code directory.
RUN git clone https://github.com/Atheos/Atheos /tmp/Atheos
RUN mv /tmp/Atheos/* /var/www/html/

RUN ls /var/www/html/

# VOLUME /code


# Ports and volumes.
EXPOSE 80