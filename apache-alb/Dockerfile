FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

ENV APACHE_DOCUMENT_ROOT /var/www/html

RUN apt-get update && apt-get install -yq --no-install-recommends \
    apt-utils \
    curl \
    # Install apache
    apache2 \
    # Install php 7.2
    libapache2-mod-php7.2 \
    php7.2-cli \
    php7.2-json \
    php7.2-curl \
    php7.2-mbstring \
    php7.2-soap \
    php7.2-xml \
    php7.2-zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY 000-default.conf /etc/apache2/sites-available/
COPY apache2.conf /etc/apache2/
RUN a2enmod remoteip


EXPOSE 80
COPY app/ /var/www/html
WORKDIR /var/www/html

HEALTHCHECK --interval=5s --timeout=3s --retries=3 CMD curl -f http://localhost || exit 1

CMD apachectl -D FOREGROUND 