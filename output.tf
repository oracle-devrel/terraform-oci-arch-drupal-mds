output "drupal_public_ip" {
  value = module.drupal.public_ip
}

output "drupal_db_user" {
  value = module.drupal.drupal_user_name
}

output "drupal_schema" {
  value = module.drupal.drupal_schema_name
}

output "drupal_db_password" {
  value = var.dp_password
}

output "mds_instance_ip" {
  value = module.mds-instance.mysql_db_system.ip_address
  sensitive = true
}

output "ssh_private_key" {
  value = local.private_key_to_show
  sensitive = true
}
