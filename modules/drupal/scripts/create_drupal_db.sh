#!/bin/bash


DEDICATED=${dedicated}
INSTANCE=${instancenb}

if [ "$DEDICATED" == "true" ]
then
   dpschema="${dp_schema}$INSTANCE"
   dpname="${dp_name}$INSTANCE"
else
   dpschema="${dp_schema}"
   dpname="${dp_name}"
fi


mysqlsh --user ${admin_username} --password=${admin_password} --host ${mds_ip} --sql -e "CREATE DATABASE $dpschema;"
mysqlsh --user ${admin_username} --password=${admin_password} --host ${mds_ip} --sql -e "CREATE USER $dpname identified by '${dp_password}';"
mysqlsh --user ${admin_username} --password=${admin_password} --host ${mds_ip} --sql -e "GRANT ALL PRIVILEGES ON $dpschema.* TO $dpname;"

echo "Drupal Database and User created !"
echo "DRUPAL USER = $dpname"
echo "DRUPAL SCHEMA = $dpschema"
