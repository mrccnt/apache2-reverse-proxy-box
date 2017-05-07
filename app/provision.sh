#!/usr/bin/env bash

echo "" >> /etc/hosts
echo "192.168.1.122        entry entry.dev www.entry.dev" >> /etc/hosts
echo "192.168.1.124        maria maria.dev" >> /etc/hosts

apt-get update
apt-get upgrade -y

apt-get -qq install -y curl wget vim apache2 apache2-utils

a2enmod rewrite
a2enmod headers
a2dismod status
a2dissite 000-default.conf

sed -i 's/www-data/ubuntu/g' /etc/apache2/envvars
ln -s /var/www/app.dev/app_dev.conf /etc/apache2/sites-enabled/app_dev.conf

/etc/init.d/apache2 restart

cp /var/www/app.dev/logrotate /etc/logrotate.d/appdev