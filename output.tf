## Copyright (c) 2022 Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

output "drupal_home_URL" {
  value = "http://${module.drupal.public_ip[0]}/"
}

output "generated_ssh_private_key" {
  value     = module.drupal.generated_ssh_private_key
  sensitive = true
}

output "drupal_name" {
  value = var.drupal_name
}

output "drupal_password" {
  value = var.drupal_password
}

output "drupal_database" {
  value = var.drupal_schema
}

output "mds_instance_ip" {
  value = module.mds-instance.mysql_db_system.ip_address
  sensitive = true
}