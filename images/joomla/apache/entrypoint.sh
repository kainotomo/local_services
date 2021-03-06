#!/bin/bash

set -e

# Start ssh
mkdir -p /run/sshd
/usr/sbin/sshd

# cp php overrides
cd /home/docker
cp php-ini-overrides.ini /usr/local/etc/php/conf.d/99-overrides.ini

# setup azure
cd /var/www/html
if [ ! -f configuration.php ]; then
    cd /home/code
    cp -r -f * /var/www/html
    cd /var/www/html
    cp htaccess.txt .htaccess
    cp configuration.azure.php configuration.php
fi
cd /var/www/html
chown -R www-data:www-data images
if [ ! -d administrator/logs ]; then
 mkdir administrator/logs
fi
chown -R www-data:www-data administrator/logs
if [ ! -d administrator/cache ]; then
 mkdir administrator/cache
fi
chown -R www-data:www-data administrator/cache
chown -R www-data:www-data administrator/logs
if [ ! -d tmp ]; then
 mkdir tmp
fi
chown -R www-data:www-data tmp
chown -R www-data:www-data configuration.php

exec "$@"
