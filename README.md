# Nginx Docker Image with FastCGI

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/eric-mathison/docker-wordpress-nginx/Build%20Docker%20Image%20and%20Push?style=for-the-badge)

This is a Nginx Docker Image designed to work with this [Wordpress PHP Docker Image](https://github.com/eric-mathison/docker-wordpress-php). This image includes common routes for Wordpress and configuration for Nginx FastCGI cache.

## How to Use this Image

### Start a `nginx` server instance

```bash
docker run -p 80:80 --name nginx -e FASTCGI_HOST=localhost -d ericmathison/nginx:tag
```

Once the container has started, you can browse or curl http://localhost:80.

### Using Docker Compose

Example docker-compose.yml file:

```yaml
version: "3.3"

services:
    nginx:
        image: ericmathison/nginx:latest
        restart: always
        volumes:
            - wp-data:/var/www/html
            - nginxfastcgi:/var/cache/nginxfastcgi
        environment:
            FASTCGI_HOST: localhost
```

### Environment Variables

When you use this image, you will need to supply the address for your FastCGI host. This can be specified by either `IP Address` or `DNS Name`.

**`FASTCGI_HOST`**

Set this to either the `IP Address` or `DNS Name` of the container running your PHP application. The port defaults at `9000`.

## Configuration

### Defaults

This image sets the `worker_processes` to `auto` and `worker_connections` to `8192`. These directives are set in the `Dockerfile`.

Default html block directives can be found in `conf/default.conf`. These settings can be changed to any value.

Virtual Server block directives are configured in the files located in the `/global/` directory.

-   `/global/locations.conf.template` Location Rules
-   `/global/nocache.conf.template` Cache Skipping Rules
-   `/global/proxy.conf.template` RealIP Rules
-   `/global/secure.conf.template` Basic Security Rules

### Caching

The caching directory is located in `/var/cache/nginxfastcgi/`.  
By default, inactive cache is set to purge after `90 minutes`. Resources served with a `200, 301, 302, or 404` response are cached for `60 minutes`. Nginx is allowed to serve stale cache, in case of server problems.

> FastCGI cache is skipped whenever one of the following situations is true:
>
> -   it's a POST request
> -   the request includes a query string
> -   the request is a non-cachable Wordpress URL (/wp-admin, /wp-login, /xmlrpc.php, /sitemap)
> -   the request is for a WooCommerce URL (/cart, /my-account, /checkout)
> -   the request includes specific cookies

#### Custom Caching Rules

If you need to add custom `no cache` rules, they can be added in a custom `.conf` file located in the `/etc/nginx/globals/` directory.  
Use the following variables in your ruleset:

-   `$skip_custom_cache`
-   `$custom_skip_reason`

### Proxying

If you are using this Nginx image behind a reverse proxy like Cloudflare or a Docker Load Balancer, you can add the IP address(es) of the load balancer to the `/global/proxy.conf.template` file.

### GH Actions

This repo is configured to automatically build this Docker image and upload it to your Docker Hub account.

1. To setup this action, you need to set the following enviroment secrets:

-   `DOCKERHUB_USERNAME` - this is your Docker Hub username
-   `DOCKERHUB_TOKEN` - this is your Docker Hub API key

2. You need to update the tags for the build in `/.github/workflows/deploy.yml` on line 26.
