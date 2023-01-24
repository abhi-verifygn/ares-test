#!/usr/bin/env bash

sudo apt-get purge 'php*' -y
sudo apt-get purge --auto-remove lighttpd -y
sudo rm -rf /usr/local/mysql/
sudo rm  /usr/local/bin/mysql
sudo rm  /etc/init.d/mysql.server
sudo rm -rf /etc/mysql
sudo rm /etc/my.cnf
sudo rm -rf /var/www/html/*
sudo apt-get autoclean
sudo apt-get update --fix-missing
sudo apt-get upgrade

