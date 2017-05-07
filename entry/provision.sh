#!/usr/bin/env bash

echo "" >> /etc/hosts
echo "192.168.1.123        app app.dev www.app.dev" >> /etc/hosts
echo "192.168.1.124        maria maria.dev" >> /etc/hosts

apt-get update
apt-get upgrade -y

apt-get -qq install -y curl wget vim apache2 apache2-utils libaprutil1-dbd-mysql

# a2enmod unique_id
a2enmod rewrite
# a2enmod ssl
a2enmod headers
a2enmod proxy
a2enmod proxy_http
a2enmod proxy_html
a2enmod xml2enc
a2enmod auth_form
a2enmod session
a2enmod session_cookie
a2enmod session_crypto
a2enmod request
a2enmod authn_dbd
a2dismod status
a2dissite 000-default.conf

sed -i 's/www-data/ubuntu/g' /etc/apache2/envvars
ln -s /var/www/entry.dev/entry_dev.conf /etc/apache2/sites-enabled/entry_dev.conf
ln -s /var/www/entry.dev/app_module.conf /etc/apache2/conf-enabled/app_module.conf

/etc/init.d/apache2 restart

cp /var/www/entry.dev/logrotate /etc/logrotate.d/entrydev