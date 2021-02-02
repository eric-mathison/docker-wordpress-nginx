FROM nginx:1.19

ENV NGINX_ENVSUBST_OUTPUT_DIR=/etc/nginx/global

COPY conf/default.conf /etc/nginx/conf.d/default.conf
COPY global/locations.conf.template /etc/nginx/templates/
COPY global/nocache.conf.template /etc/nginx/templates/
COPY global/secure.conf.template /etc/nginx/templates/
COPY global/proxy.conf.template /etc/nginx/templates/
COPY fastcgi-permissions.sh /docker-entrypoint.d

RUN mkdir /etc/nginx/global
RUN chmod +x /docker-entrypoint.d/fastcgi-permissions.sh

RUN sed -i 's/user  nginx/user  www-data/' /etc/nginx/nginx.conf
RUN sed -i 's/worker_processes  1;/worker_processes  auto;\nworker_rlimit_nofile 4096;/' /etc/nginx/nginx.conf
RUN sed -i 's/worker_connections  1024;/worker_connections  2048;\nuse epoll;/' /etc/nginx/nginx.conf