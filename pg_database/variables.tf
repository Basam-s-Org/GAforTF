### Azure Provider Credential Variables

variable "azure_subscription_id" {
  type = string
}

variable "azure_tenant_id" {
  type = string
}

variable "azure_client_id" {
  type = string
}

variable "azure_client_secret" {
  type = string
}


### Instaclustr Provider User and Key Credentials

variable "instaclustr_api_cred" {
  type = string
}


### Azure Resource Group Variables for Key Vault

variable "rg_name" {
  type = string
}

variable "rg_location" {
  type    = string
}


####  Azure PostgreSQL database Firewall Paramters

# firewall_rules: Firewall Allow CIDR list. Default is no firewall rules.

variable "firewall_rules"{
  type    = list
  default = []
}


#### Azure PostgreSQL RDBMS Parameters

# sla_tier: SLA Tier of the cluster. Non-production clusters may receive
# lower priority support and reduced SLAs. Production tier is not
# available when using Developer class nodes. Default to to NON_PRODUCTION

variable "sla_tier" {
  type    = string
  default = "NON_PRODUCTION"
}

# synchronous_mode_strict: When enabled, this option enforces that all
# commits must be replicated to at least one standby.

variable "synchronous_mode_strict" {
  type    = string
  default = false
}


# db_name: PostgreSQL cluster name

variable "db_name" {
  type    = string
}


# db_version: Version of PosgreSQL to deploy

variable "db_version" {
  type    = string
  default = "16.2.0"
}

# private_network_cluster: Creates the cluster with private network only.
# Default set to false

variable "private_network_cluster" {
  type    = string
  default = false
}


# db_secret_kv: Azure Key Vault in which to add the database password

variable "db_secret_kv" {
  type    = string
}

# db_extensions: List of PostgreSQL extensions.

variable "db_extensions" {
  type    = list
  default = []
}

# provider_account_name: For customers running in their own account. Your provider
# account can be found on the Create Cluster page on the Instaclustr Console, or the
# "Provider Account" property on any existing cluster. For customers provisioning on
# Instaclustr's cloud provider accounts, this property may be omitted.
# default value is set to INSTACLUSTR

variable "provider_account_name" {
  type    = string
  default = "INSTACLUSTR"
}

# dc_name: Optional name of the datacenter. It is set to
# "${var.cloud_provider}_${var.cloud_provider_region}" if unset


variable "dc_name" {
  type    = string
  default = null
}

# node_side: Size of the node.  Default to PGS-PRD-Standard_E8s_v4-ANF-2048

variable "db_node_size" {
  type    = string
  default = "PGS-PRD-Standard_E8s_v4-ANF-2048"
}


# number_of_nodes: Number of nodes to provision in data centre

variable "db_number_of_nodes" {
  type    = number
  default = 2 
}

# dc_network: The private network address block for the Data Centre
# specified using CIDR address notation. The network must have a prefix
# length between /12 and /22 and must be part of a private address space.
# Set default to 10.4.0.0/16

variable "dc_network" {
  type    = string
  default = "10.4.0.0/16"
}

# storage_network: Private network address block to be used for the storage network.
# This is only used for certain node sizes, currently limited to those
# which use Azure NetApp Files: for all other node sizes, this field should
# not be provided. The network must have a prefix length between /16 and /28,
# and must be part of a private address range.

variable "storage_network" {
  type    = string
  default = "10.3.0.0/24"
}

# client_to_cluster_encryption: Enable client to cluster Encryption. Default is false.

variable "client_to_cluster_encryption" {
  type    = string
  default = "false"
}

# db_replication_mode: Create the PostgreSQL cluster with the selected replication mode.
# Either ASYNCHRONOUS or SYNCHRONOUS.  Default is SYNCHRONOUS

variable "db_replication_mode" {
  type    = string
  default = "SYNCHRONOUS" 
}



# cloud_provider: Name of a cloud provider service.
# Options are: AWS_VPC, GCP, AZURE, AZURE_AZ, ONPREMISES
# Note:  AZURE_AZ is the cloud provide to use when provisioning in Azure with ANF

variable "cloud_provider" {
  type    = string
  default = "AZURE_AZ"
}

# cloud_provider_region: Region of the data centre. Default is CENTRAL_US

variable "cloud_provider_region" {
  type    = string
  default = "CENTRAL_US"

}
