echo 'azure_subscription_id="${TF_VAR_AZURE_SUBSCRIPTION_ID}"' > terraform.tfvars
echo 'azure_tenant_id="${TF_VAR_TENANT_ID}"' >> terraform.tfvars
echo 'azure_client_id="${TF_VAR_AZURE_CLIENT_ID}"' >> terraform.tfvars
echo 'azure_client_secret="${TF_VAR_CLIENT_SECRET}"' >> terraform.tfvars
echo 'instaclustr_api_cred="${TF_VAR_INSTACLUSTR_API_CRED}"' >> terraform.tfvars
echo 'rg_name="${TF_VAR_RG_NAME}"' >> terraform.tfvars
echo 'rg_location="${TF_VAR_RG_LOCATION}"' >> terraform.tfvars
echo 'db_name="${TF_VAR_DB_NAME}"' >> terraform.tfvars
echo 'db_version="${TF_VAR_DB_VERSION}"' >> terraform.tfvars
echo 'db_secret_kv="${TF_VAR_DB_SECRET_KV}"' >> terraform.tfvars
echo 'firewall_rules="${TF_VAR_FIREWALL_RULES}"' >> terraform.tfvars
echo 'cloud_provider="${TF_VAR_CLOUD_PROVIDER}"' >> terraform.tfvars
echo 'db_extensions="${TF_VAR_DB_EXTENSIONS}"' >> terraform.tfvars
echo 'dc_name="${TF_VAR_DC_HOME}"' >> terraform.tfvars

