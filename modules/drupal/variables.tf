## Copyright (c) 2022 Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "mysql_version" {
  description = "The version of the Mysql Shell."
  default     = "8.0.26"
}

variable "tenancy_ocid" {
}

variable "vcn_id" {
  description = "The OCID of the VCN"
  default     = ""
}

variable "drupal_subnet_id" {
  description = "The OCID of the drupal subnet to create the VNIC for public/private access. "
  default     = ""
}

variable "lb_subnet_id" {
  description = "The OCID of the Load Balancer subnet to create the VNIC for public access. "
  default     = ""
}

variable "bastion_subnet_id" {
  description = "The OCID of the Bastion subnet to create the VNIC for public access. "
  default     = ""
}

variable "fss_subnet_id" {
  description = "The OCID of the File Storage Service subnet to create the VNIC for private access. "
  default     = ""
}

variable "compartment_ocid" {
  description = "Compartment's OCID where VCN will be created. "
}

variable "availability_domain_name" {
  description = "The Availability Domain of the instance."
  default     = ""
}

variable "display_name" {
  description = "The name of the instance. "
  default     = ""
}

variable "subnet_id" {
  description = "The OCID of the Shell subnet to create the VNIC for public access. "
  default     = ""
}

variable "shape" {
  description = "Instance shape to use for master instance. "
  default     = "VM.Standard.E4.Flex"
}

variable "flex_shape_ocpus" {
  description = "Flex Instance shape OCPUs"
  default = 1
}

variable "flex_shape_memory" {
  description = "Flex Instance shape Memory (GB)"
  default = 6
}

variable "lb_shape" {
  default = "flexible"
}

variable "flex_lb_min_shape" {
  default = "10"
}

variable "flex_lb_max_shape" {
  default = "100"
}


variable "use_bastion_service" {
  default = false
}

variable "bastion_service_region" {
  description = "Bastion Service Region"
  default     = ""
}

variable "bastion_image_id" {
  default = ""
}

variable "bastion_shape" {
  default = "VM.Standard.E4.Flex"
}

variable "bastion_flex_shape_ocpus" {
  default = 1
}

variable "bastion_flex_shape_memory" {
  default = 1
}

variable "use_shared_storage" {
  description = "Decide if you want to use shared NFS on OCI FSS"
  default     = true
}

variable "drupal_shared_working_dir" {
  description = "Decide where to store drupal data"
  default     = "/shareddrupal"
}

variable "label_prefix" {
  description = "To create unique identifier for multiple clusters in a compartment."
  default     = ""
}

variable "assign_public_ip" {
  description = "Whether the VNIC should be assigned a public IP address. Default 'false' do not assign a public IP address. "
  default     = true
}

variable "ssh_authorized_keys" {
  description = "Public SSH keys path to be included in the ~/.ssh/authorized_keys file for the default user on the instance. "
  default     = ""
}

variable "image_id" {
  description = "The OCID of an image for an instance to use. "
  default     = ""
}

variable "vm_user" {
  description = "The SSH user to connect to the master host."
  default     = "opc"
}

variable "drupal_name" {
  description = "drupal Database User Name."
}

variable "drupal_password" {
  description = "drupal Database User Password."
}

variable "drupal_schema" {
  description = "drupal MySQL Schema"
}

variable "drupal_prefix" {
  description = "drupal MySQL Prefix"
  default = "drupal_"
}

variable "admin_username" {
    description = "Username od the MDS admin account"
}

variable "admin_password" {
    description = "Password for the admin user for MDS"
}

variable "mds_ip" {
    description = "Private IP of the MDS Instance"
}

variable "numberOfNodes" {
    description = "Amount of Webservers to deploy"
    default = 1
}

variable "use_AD" {
  description = "Using different Availability Domain, by default use of Fault Domain"
  type        = bool
  default     = false
}

variable "dedicated" {
  description = "Create a dedicated user and a dedicated database for each Webservers"
  type        = bool
  default     = false
}

# Dictionary Locals
locals {
  compute_flexible_shapes = [
    "VM.Standard.E3.Flex",
    "VM.Standard.E4.Flex",
    "VM.Standard.A1.Flex",
    "VM.Optimized3.Flex"
  ]
}

# Checks if is using Flexible Compute Shapes
locals {
  is_flexible_node_shape = contains(local.compute_flexible_shapes, var.shape)
  is_flexible_lb_shape   = var.lb_shape == "flexible" ? true : false
}

variable "defined_tags" {
  description = "Defined tags for WordPress host."
  default     = ""
}
