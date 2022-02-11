# terraform-oci-arch-drupal-mds

## Reference Architecture

Drupal is one of the most popular content management systems (CMS) available. It is free and open-source, released under the GNU Public License. 

Drupal is based on the LAMP stack and provides users and enterprises a scalable and robust architecture, low implementation and maintenance efforts, as well as a large community-led knowledge base. Its setup and usage does not require advanced technical skills. It provides the infrastructure for websites worldwide—ranging from personal blogs to corporate, political, and government sites. It is very extensible and modular, making it useful in a large variety of scenarios.

This Terraform code spins up one or more Oracle Cloud Infrastructure (OCI) instances after creating the required OCI networking components, deploys Drupal on the instance(s) and creates a MySQL Database System (with High Availability if desired).

For more details on the architecture, see [_Deploy Drupal CMS on Oracle Linux with MySQL Database Service_](https://docs.oracle.com/en/solutions/drupal-with-mds/)

## Architecture Diagram (Single-node version)

![](./images/architecture-deploy-drupal-mds.png)

## Prerequisites

- Permission to `manage` the following types of resources in your Oracle Cloud Infrastructure tenancy: `vcns`, `internet-gateways`, `route-tables`, `security-lists`, `subnets`, `mysql-family`, and `instances`.

- Quota to create the following resources: 1 VCN, 2 subnets, 1 Internet Gateway, 1 NAT Gateway, 2 route rules, 1 MySQL Database System (MDS) instance, and 1 (or more) compute instance(s) for Drupal.

If you don't have the required permissions and quota, contact your tenancy administrator. See [Policy Reference](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Reference/policyreference.htm), [Service Limits](https://docs.cloud.oracle.com/en-us/iaas/Content/General/Concepts/servicelimits.htm), [Compartment Quotas](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/resourcequotas.htm).

## Deploy Using Oracle Resource Manager

1. Click [![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?region=home&zipUrl=https://github.com/oracle-devrel/terraform-oci-arch-drupal-mds/releases/latest/download/terraform-oci-arch-drupal-mds-stack-latest.zip)


    If you aren't already signed in, when prompted, enter the tenancy and user credentials.

2. Review and accept the terms and conditions.

3. Select the region where you want to deploy the stack.

4. Follow the on-screen prompts and instructions to create the stack.

5. After creating the stack, click **Terraform Actions**, and select **Plan**.

6. Wait for the job to be completed, and review the plan.

    To make any changes, return to the Stack Details page, click **Edit Stack**, and make the required changes. Then, run the **Plan** action again.

7. If no further changes are necessary, return to the Stack Details page, click **Terraform Actions**, and select **Apply**. 

## Deploy Using the Terraform CLI

### Clone the Module

Now, you'll want a local copy of this repo. You can make that with the commands:

```
    git clone https://github.com/oracle-devrel/terraform-oci-arch-drupal-mds.git
    cd terraform-oci-arch-drupal-mds
    ls
```

### Prerequisites
First off, you'll need to do some pre-deploy setup.  That's all detailed [here](https://github.com/cloud-partners/oci-prerequisites).

Create a `terraform.tfvars` file, and specify the following variables:

```
# Authentication
tenancy_ocid        = "<tenancy_ocid>"
user_ocid           = "<user_ocid>"
fingerprint         = "<finger_print>"
private_key_path    = "<pem_private_key_path>"

region              = "<oci_region>"
compartment_ocid    = "<compartment_ocid>"

# MySQL and Drupal variables
admin_username      = "<MySQL_admin_username>"
admin_password      = "<MySQL_admin_password>"
mds_instance_name   = "<MySQL_instance_name>"
dp_instance_name    = "<Drupal_instance_name>"
dp_name             = "<Drupal_user_name>"
dp_password         = "<Drupal_user_password>"
dp_schema           = "<Drupal_schema_name>"

````

### Create the Resources
Run the following commands:

    terraform init
    terraform plan
    terraform apply

### Destroy the Deployment
When you no longer need the deployment, you can run this command to destroy the resources:

    terraform destroy

## Deploy as a Module
It's possible to utilize this repository as remote module, providing the necessary inputs:

```
module "oci-arch-drupal-mds" {
  source                        = "github.com/oracle-devrel/terraform-oci-arch-drupal-mds"
  tenancy_ocid                  = "<tenancy_ocid>"
  user_ocid                     = "<user_ocid>"
  fingerprint                   = "<finger_print>"
  private_key_path              = "<private_key_path>"
  region                        = "<oci_region>"
  admin_username                = "<MySQL_admin_username>"
  admin_password                = "<MySQL_admin_password>"
  mds_instance_name             = "<MySQL_instance_name>"
  dp_instance_name              = "<Drupal_instance_name>"
  dp_name                       = "<Drupal_user_name>"
  dp_password                   = "<Drupal_user_password>"
  dp_schema                     = "<Drupal_schema_name>"
}
```

### Testing your Deployment
After the deployment is finished, you can access and configure Drupal by picking drupal_public_ip from the output and pasting into web browser window.

````
drupal_public_ip = http://193.122.198.20/
`````


## Contributing
This project is open source.  Please submit your contributions by forking this repository and submitting a pull request!  Oracle appreciates any contributions that are made by the open source community.

## Attribution & Credits
This repository was initially inspired on the materials found in [lefred's blog](https://lefred.be/content/deploying-drupal-in-oci-using-mds-the-easy-way/). One of the enhancements done to the materials in question was the adoption of the [OCI Cloudbricks MySQL module](https://github.com/oracle-devrel/terraform-oci-cloudbricks-mysql-database).
That being the case, we would sincerely like to thank:
- Frédéric Descamps (https://github.com/lefred)
- Denny Alquinta (https://github.com/dralquinta)

## License
Copyright (c) 2022 Oracle and/or its affiliates.

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](LICENSE) for more details.
