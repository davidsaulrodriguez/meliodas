ARG COMPOSER_VERSION

FROM composer:${COMPOSER_VERSION}

ENV COMPOSER_USER=1000
ENV COMPOSER_GROUP=1000

RUN adduser -g ${COMPOSER_GROUP} -s /bin/sh -D ${COMPOSER_USER}