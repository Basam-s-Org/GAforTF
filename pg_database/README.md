# Instaclustr PostgreSQL Database Terraform Project

This project contains Terraform configurations to provision Instaclustr-managed PostgreSQL database with the   following components:
- An Azure Key Vault (AKV)
- A PostgreSQL cluster with ANF storage on Azure (PG)
- An firewall rule added to allow incoming connections to PG
- PG admin password store in AKV 

## Modules

### Key Vault Module

**Goal**: Create and manage an Azure Key Vault.

**Inputs**:
- `azure_subscription_id` (string): The ID for the Azure subscription.
- `azure_tenant_id` (string): The tenant ID for the Azure subscription
- `azure_client_id` (string): The client ID for the Azure subscription.
- `azure_client_secret` (string): The lient secret for the Azure subscription.
- `rg_name` (string): The name of the resource group
- `rg_location` (string): The location of the resource group.
- `db_secret_kv` (string):  The key vault name where database secrets are to be stored

**Outputs**:
- `key_vault_id` (string): The ID of the Azure Key Vault.

### PG RDBMS Module

**Goal**: Create an Instaclustr managed PostgreSQL cluster with ANF storage

**Inputs**:

- `azure_subscription_id` (string): The ID for the Azure subscription.
- `azure_tenant_id` (string): The tenant ID for the Azure subscription
- `azure_client_id` (string): The client ID for the Azure subscription.
- `azure_client_secret` (string): The lient secret for the Azure subscription.
- `rg_name` (string): The name of the resource group
- `rg_location` (string): The location of the resource group.
- `instaclustr_api_cred` (string): The username namd API key used for provisioning.  Format of this parameter is <user>:api_key
- `db_name` (string):  The desired name of the database
- `db_version` (string):  The version of the PostgreSQL to use for the database
- `db_secret_kv` (string):  The key vault name where database secrets are to be stored

**Outputs**:
- `cluster_id` (string): The unique cluster ID generated for the new database.
- `default_user_password` (string): Random password generated for the new database.

### Firewall Module

**Goal**: Whitelist a list of IP address to access a database

**Inputs**:
- `instaclustr_api_cred` (string): The username namd API key used for provisioning.  Format of this parameter is <user>:api_key
- `rg_name` (string): The name of the resource group.
- `rg_location` (string): The location of the resource group.
- `cluster_id` (string): The ID of the cluster which to add permitted CIDRs.
- `firewall_rules` (list): A list of CIDRs allowed to access the database cluster

### Database Secret Module

**Goal**: Add the database clsuter administrator password to a specified key vault

**Inputs**:
- `azure_subscription_id` (string): The ID for the Azure subscription.
- `azure_tenant_id` (string): The tenant ID for the Azure subscription
- `azure_client_id` (string): The client ID for the Azure subscription.
- `azure_client_secret` (string): The lient secret for the Azure subscription.
- `rg_name` (string): The name of the resource group.
- `rg_location` (string): The location of the resource group.
- `db_name`  (string): The Name of the database.  This is included in the name of the secret
- `default_user_password` (string): The password to store in the key vault secret
- `keyvault_id` (string): The ID of the key vault in which to store the database secret



## Root Main Script Flow

1. **Provider Configuration**:
   - Configure the AzureRM provider with subscription ID, tenant ID, client ID, and client secret.
   - Configure the Instaclustr provider with user and api key

3. **Create Resource Group**:
   - Create an Azure resource group where all resources will be deployed.

4. **Deploy Key Vault Module**:
   - Create an Azure Key Vault to store secrets securely.

5. **Deploy PostgreSQL database cluster**:

6. **Add IP address CIDRs to the Allow list**
   - Add list of allowed CIDRs to database.  The database cluster id retrieved from PG RDBMS module output

6. **Deploy Container Instance Module**:
   - Add database secret to keyvault using the Key Vault ID from Key Vault module output, and the password from the PG RDBMS module output.

## End Result

The Terraform configuration sets up an infrastructure where:
- An Azure Key Vault securely stores the database credentials.
- A PostgreSQL database cluster
