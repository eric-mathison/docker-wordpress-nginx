FROM nginx:latest
COPY default.conf /etc/nginx/conf.d/default.conf
COPY basic.conf /etc/nginx/global/basic.conf
COPY secure.conf /etc/nginx/global/secure.conf
COPY locations.conf /etc/nginx/global/locations.conf
COPY proxy.conf /etc/nginx/global/proxy.conf
COPY docker-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

RUN sed -i 's/user  nginx/user  www-data/' /etc/nginx/nginx.conf

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]