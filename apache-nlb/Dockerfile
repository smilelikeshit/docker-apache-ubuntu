FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

ENV APACHE_DOCUMENT_ROOT /var/www/html

WORKDIR /var/www/html

RUN apt-get update && apt-get install -yq --no-install-recommends \
    apt-utils \
    curl \
    git \
    # Install apache
    apache2 \
    apache2-dev \
    # Install php 7.2
    libapache2-mod-php7.2 \
    php7.2-cli \
    php7.2-json \
    php7.2-curl \
    php7.2-mbstring \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/roadrunner2/mod-proxy-protocol.git \
    && cd mod-proxy-protocol \
    && apxs -i -a -c mod_proxy_protocol.c


COPY 000-default.conf /etc/apache2/sites-available/
COPY apache2.conf /etc/apache2/
COPY index.php /var/www/html

EXPOSE 80
HEALTHCHECK --interval=5s --timeout=3s --retries=3 CMD curl -f http://localhost || exit 1
CMD apachectl -D FOREGROUND 