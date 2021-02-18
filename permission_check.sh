#!/bin/bash
set -e

user='33'
group='33'

echo 'Checking NginxFastCGI Folder Existence'
if [ -e /var/cache/nginxfastcgi/ ]; then
  if [ "$(stat -c '%u:%g' /var/cache/nginxfastcgi/)" != '$user:$group' ]; then
    echo 'Changing NginxFastCGI Folder Permissions'
    chown "$user:$group" /var/cache/nginxfastcgi/
  fi
fi

exec "$@"
