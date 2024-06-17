echo -e "azure_subscription_id=\""${TF_VAR_AZURE_SUBSCRIPTION_ID}"\"\n" > ./terraform.tfvars
echo -e "azure_tenant_id=\""${TF_VAR_AZURE_TENANT_ID}"\"\n" >> ./terraform.tfvars
echo -e "azure_client_id=\""${TF_VAR_AZURE_CLIENT_ID}"\"\n">> ./terraform.tfvars
echo -e "azure_client_secret=\""${TF_VAR_AZURE_CLIENT_SECRET}"\"\n" >> ./terraform.tfvars
echo -e "dockerfiles=\""${TF_VAR_CLIENT_DOCKERFILS}"\"\n" >> ./terraform.tfvars
echo -e "aci_cpu=\""${TF_VAR_CLIENT_ACI_CPU}"\"\n" >> ./terraform.tfvars
echo -e "aci_memory=\""${TF_VAR_CLIENT_MEMORY}"\"\n" >> ./terraform.tfvars
echo -e "tags=\""${TF_VAR_CLIENT_TAGS}"\"\n" >> ./terraform.tfvars
cat ./terraform.tfvars
