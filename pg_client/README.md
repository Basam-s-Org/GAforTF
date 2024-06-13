# pg_client Terraform Module

This module contains Terraform configurations to deploy an Azure infrastructure with the following components:
- An Azure Key Vault (AKV)
- An Azure Container Registry (ACR)
- An Azure Container Instance (ACI) that retrieves its credentials from the AKV

This module is designed to create all the necessary infrastructure to deploy an Azure Container Instance with two containers: one for Postgres Helper and another for SQL Alchemy.

## Modules

### Key Vault Module

**Goal**: Create and manage an Azure Key Vault.

**Inputs**:
- `key_vault_name` (string): The name of the Azure Key Vault.
- `location` (string): The location of the resource group.
- `resource_group_name` (string): The name of the resource group.
- `tenant_id` (string): The tenant ID for the Azure subscription.
- `object_id` (string): The object ID of the user or service principal to grant access.

**Outputs**:
- `key_vault_id` (string): The ID of the Azure Key Vault.

### Container Registry Module

**Goal**: Create and manage an Azure Container Registry (ACR) and store its credentials in the Key Vault.

**Inputs**:
- `rg_name` (string): The name of the resource group.
- `rg_location` (string): The location of the resource group.
- `acr_name` (string): The name of the Azure Container Registry.
- `dockerfiles` (map): A map of Dockerfile names and corresponding image names.
- `key_vault_id` (string): The ID of the Azure Key Vault.

**Outputs**:
- `acr_login_server` (string): The login server of the Azure Container Registry.

### Container Instance Module

**Goal**: Create and manage an Azure Container Instance (ACI) that retrieves its credentials from the Azure Key Vault. This module creates a single ACI with all the container definitions listed in the variable. The Dockerfiles are in a folder called "dockerfiles" and those files are used during ACR creation to build the images that are going to be deployed by ACI. Currently, there are two containers: PG Helper and SQL Alchemy.

**Inputs**:
- `rg_name` (string): The name of the resource group.
- `rg_location` (string): The location of the resource group.
- `aci_name` (string): The name of the Azure Container Instance.
- `acr_login_server` (string): The login server of the Azure Container Registry.
- `key_vault_id` (string): The ID of the Azure Key Vault.
- `acr_username_secret_name` (string): The name of the secret in Key Vault for ACR username.
- `acr_password_secret_name` (string): The name of the secret in Key Vault for ACR password.
- `pg_host` (string): The PostgreSQL server address.
- `pg_user` (string): The PostgreSQL username.
- `pg_password` (string): The PostgreSQL password.
- `pg_db` (string): The PostgreSQL database name.
- `aci_cpu` (number): The CPU allocation for the container instance.
- `aci_memory` (number): The memory allocation for the container instance.
- `dockerfiles` (map): A map of Dockerfile names and corresponding image names.
- `tags` (map): Tags for organizing resources.

## Root Main Script Flow

1. **Provider Configuration**:
   - Configure the AzureRM provider with subscription ID, tenant ID, client ID, and client secret.

2. **Retrieve Current Azure Client Configuration**:
   - Retrieve the current Azure client configuration to obtain the object ID of the service principal.

3. **Create Resource Group**:
   - Create an Azure resource group where all resources will be deployed.

4. **Deploy Key Vault Module**:
   - Create an Azure Key Vault to store secrets securely.

5. **Deploy Container Registry Module**:
   - Create an Azure Container Registry (ACR) and store its credentials in the Azure Key Vault.

6. **Deploy Container Instance Module**:
   - Create an Azure Container Instance (ACI) that retrieves its credentials from the Azure Key Vault and uses Docker images from the ACR.

## End Result

The Terraform configuration sets up an infrastructure where:
- An Azure Key Vault securely stores the ACR credentials.
- An Azure Container Registry (ACR) is created to store Docker images.
- An Azure Container Instance (ACI) is deployed using the Docker images from the ACR, with credentials securely retrieved from the Azure Key Vault.
