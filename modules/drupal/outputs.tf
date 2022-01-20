output "id" {
  value = oci_core_instance.Drupal.*.id
}

output "public_ip" {
  value = join(", ", oci_core_instance.Drupal.*.public_ip)
}

output "drupal_user_name" {
  value = var.dp_name
}

output "drupal_schema_name" {
  value = var.dp_schema
}

output "drupal_host_name" {
  value = oci_core_instance.Drupal.*.display_name
}
