FROM nginx:1.19

ENV NGINX_ENVSUBST_OUTPUT_DIR=/etc/nginx/global

COPY templates/default.conf.template /etc/nginx/conf.d/default.conf
COPY templates/nocache.conf.template /etc/nginx/templates/
COPY templates/secure.conf.template /etc/nginx/templates/
COPY templates/locations.conf.template /etc/nginx/templates/
COPY templates/proxy.conf.template /etc/nginx/templates/
COPY fastcgi-permissions.sh /docker-entrypoint.d

RUN mkdir /etc/nginx/global
RUN chmod +x /docker-entrypoint.d/fastcgi-permissions.sh

RUN sed -i 's/user  nginx/user  www-data/' /etc/nginx/nginx.conf