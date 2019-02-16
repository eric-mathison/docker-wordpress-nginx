FROM nginx:latest
COPY default.conf /etc/nginx/conf.d/default.conf
COPY basic.conf /etc/nginx/global/basic.conf
COPY secure.conf /etc/nginx/global/secure.conf
COPY locations.conf /etc/nginx/global/locations.conf
COPY proxy.conf /etc/nginx/global/proxy.conf

CMD ["nginx", "-g", "daemon off;"]