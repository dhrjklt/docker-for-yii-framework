FROM php:5.6-apache

ENV TZ Asia/Kolkata
RUN requirements="nano cron   libz-dev libmemcached-dev libmcrypt-dev libmemcached-dev libmcrypt4 libcurl3-dev libxml2-dev libfreetype6 libjpeg62-turbo libpng-dev libfreetype6-dev libjpeg62-turbo-dev" \
    && apt-get update && apt-get install -y software-properties-common &&  \
    apt-get install -y --no-install-recommends $requirements && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install pdo pdo_mysql \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install curl \
    && docker-php-ext-install mysqli \
    && requirementsToRemove="libpng12-dev libmcrypt-dev libcurl3-dev libxml2-dev libpng12-dev libfreetype6-dev libjpeg62-turbo-dev" \
    && apt-get purge --auto-remove -y $requirementsToRemove \
    && pecl install memcache && echo extension=memcache.so >> /usr/local/etc/php/conf.d/memcached.ini

RUN a2enmod rewrite
RUN a2enmod ssl
RUN a2enmod proxy
RUN a2enmod proxy_http

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/server.key -out /etc/apache2/server.crt -subj "/C=AT/ST=India/L=Guwahati/O=Security/OU=Development/CN=example.com"
RUN echo "date.timezone = 'Asia/Kolkata'" >> /usr/local/etc/php/php.ini-development
RUN echo "date.timezone = 'Asia/Kolkata'" >> /usr/local/etc/php/php.ini-production

COPY ./conf/vantagecircle.conf /etc/apache2/site-enable/
COPY ./conf/vantagecircle.conf /etc/apache2/sites-enabled/
COPY ./conf/vantagecircle.conf /etc/apache2/conf-available/
COPY ./conf/vantagecircle.conf /etc/apache2/conf-available/

EXPOSE 80
EXPOSE 443
