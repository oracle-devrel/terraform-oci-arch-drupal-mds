#!/bin/bash
#set -x

cd /var/www/
wget https://www.drupal.org/download-latest/tar.gz
tar zxvf tar.gz
rm -rf html/ tar.gz
mv drupal-* html
cd html
cp sites/default/default.settings.php sites/default/settings.php
cd -
chown apache. -R html
sed -i '/AllowOverride None/c\AllowOverride All' /etc/httpd/conf/httpd.conf

systemctl start httpd
systemctl enable httpd


echo "Drupal installed and Apache started !"
