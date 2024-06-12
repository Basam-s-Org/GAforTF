echo "azure_subscription_id=\""${TF_VAR_AZURE_SUBSCRIPTION_ID}"\"\n" > ./terraform.tfvars
echo "azure_tenant_i="${TF_VAR_TENANT_ID}"\n" >> ./terraform.tfvars
echo "azure_client_id="${TF_VAR_AZURE_CLIENT_ID}"\n">> ./terraform.tfvars
echo "azure_client_secret="${TF_VAR_CLIENT_SECRET}"\n" >> ./terraform.tfvars
echo "instaclustr_api_cred="${TF_VAR_INSTACLUSTR_API_CRED}"\n" >> ./terraform.tfvars
echo "rg_name="${TF_VAR_RG_NAME}"\n">> ./terraform.tfvars
echo "rg_location="${TF_VAR_RG_LOCATION}"\n" >> ./terraform.tfvars
echo "db_name="${TF_VAR_DB_NAME}"\n" >> ./terraform.tfvars
echo "db_version="${TF_VAR_DB_VERSION}"\n">> ./terraform.tfvars
echo "db_secret_kv="${TF_VAR_DB_SECRET_KV}"\n">> ./terraform.tfvars
echo "firewall_rules="${TF_VAR_FIREWALL_RULES}"\n">> ./terraform.tfvars
echo "cloud_provider="${TF_VAR_CLOUD_PROVIDER}"\n" >> ./terraform.tfvars
echo "db_extensions="${TF_VAR_DB_EXTENSIONS}"\n" >> ./terraform.tfvars
echo "dc_name="${TF_VAR_DC_HOME}"\n" >> ./terraform.tfvars
cat ./terraform.tfvars

