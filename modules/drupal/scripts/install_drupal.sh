#!/bin/bash
#set -x

export use_shared_storage='${use_shared_storage}'

if [[ $use_shared_storage == "true" ]]; then
  echo "Mount NFS share: ${drupal_shared_working_dir}"
  yum install -y -q nfs-utils
  mkdir -p ${drupal_shared_working_dir}
  echo '${mt_ip_address}:${drupal_shared_working_dir} ${drupal_shared_working_dir} nfs nosharecache,context="system_u:object_r:httpd_sys_rw_content_t:s0" 0 0' >> /etc/fstab
  setsebool -P httpd_use_nfs=1
  mount ${drupal_shared_working_dir}
  mount
  echo "NFS share mounted."
  cd ${drupal_shared_working_dir}
else
  echo "No mount NFS share. Moving to /var/www/html" 
  cd /var/www/html	
fi

wget https://www.drupal.org/download-latest/tar.gz

if [[ $use_shared_storage == "true" ]]; then
  tar zxvf tar.gz --directory ${drupal_shared_working_dir}
  cp -r ${drupal_shared_working_dir}/drupal-*/* ${drupal_shared_working_dir}
  rm -rf ${drupal_shared_working_dir}/drupal-*
  cp ${drupal_shared_working_dir}/sites/default/default.settings.php sites/default/settings.php
else
  tar zxvf tar.gz --directory /var/www/html
  cp -r /var/www/html/drupal-*/* /var/www/html
  rm -rf /var/www/html/drupal-*
  cp /var/www/html/sites/default/default.settings.php sites/default/settings.php
fi 

if [[ $use_shared_storage == "true" ]]; then
  echo "... Changing /etc/httpd/conf/httpd.conf with Document set to new shared NFS space ..."
  sed -i 's/"\/var\/www\/html"/"\${drupal_shared_working_dir}"/g' /etc/httpd/conf/httpd.conf
  echo "... /etc/httpd/conf/httpd.conf with Document set to new shared NFS space ..."
  chown apache:apache -R ${drupal_shared_working_dir}
  sed -i '/AllowOverride None/c\AllowOverride All' /etc/httpd/conf/httpd.conf
  cp /home/opc/htaccess ${drupal_shared_working_dir}/.htaccess
  rm /home/opc/htaccess
  cp /home/opc/index.html ${drupal_shared_working_dir}/index.html
  rm /home/opc/index.html
  chown apache:apache ${drupal_shared_working_dir}/index.html
else
  chown apache:apache -R /var/www/html
  sed -i '/AllowOverride None/c\AllowOverride All' /etc/httpd/conf/httpd.conf
fi

systemctl start httpd
systemctl enable httpd

echo "Drupal installed and Apache started !"
