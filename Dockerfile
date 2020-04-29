FROM insignficant/laravel-base-image-apache74:latest


RUN a2enmod remoteip

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_DOCUMENT_ROOT /var/www/html/app

EXPOSE 80

# Copy site into place.
ADD app /var/www/html

# Update the default apache site with the config we created.
ADD apache-config.conf /etc/apache2/sites-enabled/000-default.conf

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf \
    && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf 
    #&& sed -ri -e 's/upload_max_filesize = .*/upload_max_filesize = ${MAX_UPLOAD_SIZE}/' /usr/local/etc/php/php.ini
