ARG NGINX_VERSION

FROM nginx:${NGINX_VERSION}

ENV NGINX_USER=1000
ENV NGINX_GROUP=1000

RUN mkdir -p /var/www/html/public

ADD nginx/default.prod.conf /etc/nginx/conf.d/default.conf

RUN sed -i 's/user www-data/user ${NGINX_USER}/g' /etc/nginx/nginx.conf

RUN adduser -g ${NGINX_GROUP} -s /bin/sh -D ${NGINX_USER}