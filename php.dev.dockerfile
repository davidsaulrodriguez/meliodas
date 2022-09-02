ARG PHP_DEV_VERSION

FROM php:${PHP_DEV_VERSION}-fpm-alpine

ENV PHP_USER=1000
ENV PHP_GROUP=1000

RUN adduser -g ${PHP_GROUP} -s /bin/sh -D ${PHP_USER}

RUN sed -i 's/user = www-data/user = ${PHP_USER}/g' /usr/local/etc/php-fpm.d/www.conf
RUN sed -i 's/group = www-data/group = ${PHP_GROUP}/g' /usr/local/etc/php-fpm.d/www.conf

RUN mkdir -p /var/www/html/public

RUN apk add --no-cache autoconf oniguruma-dev zlib-dev libpng-dev

ENV LIBRARY_PATH=/lib:/usr/lib

RUN apk add --no-cache $PHPIZE_DEPS \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

RUN docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd

CMD ["php-fpm", "-y", "/usr/local/etc/php-fpm.conf", "-R"]