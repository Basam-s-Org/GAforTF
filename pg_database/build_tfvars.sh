terraform import azurerm_resource_group.org_rg /subscriptions/7a07f268-eb64-45df-b63e-b5595e713287/resourceGroups/bassam-org-database

echo -e "azure_subscription_id=\""${TF_VAR_AZURE_SUBSCRIPTION_ID}"\"\n" > ./terraform.tfvars
echo -e "azure_tenant_id=\""${TF_VAR_AZURE_TENANT_ID}"\"\n" >> ./terraform.tfvars
echo -e "azure_client_id=\""${TF_VAR_AZURE_CLIENT_ID}"\"\n">> ./terraform.tfvars
echo -e "azure_client_secret=\""${TF_VAR_AZURE_CLIENT_SECRET}"\"\n" >> ./terraform.tfvars
echo -e "instaclustr_api_cred=\""${TF_VAR_INSTACLUSTR_API_CRED}"\"\n" >> ./terraform.tfvars
echo -e "rg_name=\""${TF_VAR_RG_NAME}"\"\n">> ./terraform.tfvars
echo -e "rg_location=\""${TF_VAR_RG_LOCATION}"\"\n" >> ./terraform.tfvars
echo -e "db_name=\""${TF_VAR_DB_NAME}"\"\n" >> ./terraform.tfvars
echo -e "db_version=\""${TF_VAR_DB_VERSION}"\"\n">> ./terraform.tfvars
echo -e "db_secret_kv=\""${TF_VAR_DB_SECRET_KV}"\"\n">> ./terraform.tfvars
echo -e "firewall_rules="${TF_VAR_FIREWALL_RULES}"\n">> ./terraform.tfvars
echo -e "cloud_provider=\""${TF_VAR_CLOUD_PROVIDER}"\"\n" >> ./terraform.tfvars
echo -e "db_extensions="${TF_VAR_DB_EXTENSIONS}"\n" >> ./terraform.tfvars
echo -e "dc_name=\""${TF_VAR_DC_NAME}"\"\n" >> ./terraform.tfvars
cat ./terraform.tfvars

