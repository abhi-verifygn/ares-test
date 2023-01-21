#!/usr/bin/env bash

echo 'Initiating dependency installations......'
echo 'This script is designed purely for ubuntu 20.04.5 version'
echo 'Make sure your system version will match the specified version'
echo '##############################################################'
sudo lsb_release -a
echo ' '
echo '############################################################## '
echo 'use "ctrl+z" or "ctrl+c" to abort the process'
sleep 5

sudo apt update -y
sudo apt upgrade -y

echo '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  Installing GIT > >>>>>>>>>>>>>>>>>>>>>>>>>>>>'
sudo apt install git -y
echo '.............................................................................'

echo '>>>>>>>>>>>>>>>>>>>>>>>>>>>  Installing lighttpd > >>>>>>>>>>>>>>>>>>>>>>>>>>'
sudo apt install lighttpd -y
echo '.......................................... ..................................'

echo '>>>>>>>>> Adding php(older versions) dependencies before installing >>>>>>>>>'
sudo apt install software-properties-common ca-certificates lsb-release apt-transport-https -y
echo '>>>>>>>>>>>>>>>> Adding ondrej/php repository support >>>>>>>>>>>>>>>>>>>>>>>'
sudo LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php -y
echo '#############################################################################'
sudo apt update -y
echo '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  Installing php5  >>>>>>>>>>>>>>>>>>>>>>>>>>>>'
sudo apt install php5.6-common -y
sudo apt install php5.6-cli -y
sudo apt install php5.6-cgi -y
sudo apt install php5.6-curl -y
sudo apt install php5.6-gd -y
sudo apt install php5.6-mysql -y
sudo apt install php5.6-xmlrpc -y
sudo apt install php5.6-xml -y
sudo apt install php5.6-mbstring -y
sudo apt install php-pear -y

echo '>>>>>>>>>>>>>>>>>>>>>>>>> Enabling lighttpd Fastcgi >>>>>>>>>>>>>>>>>>>>>>>>>'
sudo lighty-enable-mod fastcgi
sudo lighty-enable-mod fastcgi-php
echo '.............................................................................'

echo '>>>>>>>>>>>>>>>>>>>>>>>>>> Installing HTML Template >>>>>>>>>>>>>>>>>>>>>>>>>'
sudo pear install HTML_Template_IT
sudo pear channel-update pear.php.net
echo '.............................................................................'

sudo service lighttpd force-reload
echo 'Try to launch http://localhost on your webbrowser after the process'
sleep 5

echo '>>>>>>>>>>>>>>>>>>>>>> Deploying PHP info page onto server >>>>>>>>>>>>>>>>>>'
sudo cat > /var/www/html/info.php << EOF
<?php
phpinfo();
?>
EOF
echo '.............................................................................'

echo 'Ready to launch http://localhost/info.php on your webbrowser'
sleep 5
echo '.............................................................................'

echo '>>>>>>>>>>>>>>>>>>>>>>>>>>  Installing MySQL  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
cd ~/Downloads/
sudo wget https://downloads.mysql.com/archives/get/p/23/file/mysql-5.6.30-linux-glibc2.5-x86_64.tar.gz -y
sudo tar -xvf mysql-5.6.30-linux-glibc2.5-x86_64.tar.gz -y
sudo dpkg -i *.deb -y
sudo apt update -y
echo '.............................................................................'


read -p "Press any key to Exit > " -n1 junk
echo
