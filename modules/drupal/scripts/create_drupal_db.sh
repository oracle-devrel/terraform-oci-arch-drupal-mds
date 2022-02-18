#!/bin/bash

drupal_schema="${drupal_schema}"
drupal_name="${drupal_name}"
drupal_password="${drupal_password}"

mysqlsh --user ${admin_username} --password=${admin_password} --host ${mds_ip} --sql -e "CREATE DATABASE $drupal_schema;"
mysqlsh --user ${admin_username} --password=${admin_password} --host ${mds_ip} --sql -e "CREATE USER $drupal_name identified by '$drupal_password';"
mysqlsh --user ${admin_username} --password=${admin_password} --host ${mds_ip} --sql -e "GRANT ALL PRIVILEGES ON $drupal_schema.* TO $drupal_name;"

echo "Drupal Database and User created !"
echo "DRUPAL USER = $drupal_name"
echo "DRUPAL SCHEMA = $drupa_schema"
