#!/bin/bash
set -e

user='33'
group='33'

if [ -e var/cache/nginxfastcgi/ ]; then
  if [ "$(stat -c '%u:%g' var/cache/nginxfastcgi/)" != '$user:$group' ]; then
    echo 'Changing permissions'
    chown "$user:$group" var/cache/nginxfastcgi/
  fi
fi

exec "$@"
