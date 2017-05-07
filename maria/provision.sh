#!/usr/bin/env bash

echo "" >> /etc/hosts
echo "192.168.1.122        entry entry.dev www.entry.dev" >> /etc/hosts
echo "192.168.1.123        app app.dev www.app.dev" >> /etc/hosts

apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://mirror.klaus-uwe.me/mariadb/repo/10.1/ubuntu xenial main'

apt-get update
apt-get upgrade -y

apt-get -qq install -y curl wget vim software-properties-common

debconf-set-selections <<< 'mariadb-server mysql-server/root_password password root'
debconf-set-selections <<< 'mariadb-server mysql-server/root_password_again password root'
apt-get -q install -y mariadb-server
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/my.cnf
mysql -u root -proot < /vagrant/database.sql
/etc/init.d/mysql restart