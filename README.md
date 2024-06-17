# optum-terraform-deployment

This project is to deploy a Postgres cluster in Azure on Instaclustr platform using terraform.
<br />
It also includes other components like Azure key vault as deployment components.

Cluster deployment details on Instaclustr using terraform are referenced from the documentation here https://registry.terraform.io/providers/instaclustr/instaclustr/latest/docs/resources/postgresql_cluster_v2

NOTE: The default environment of terraform execution is Instaclustr production.
<br />
To test the terraform script in Instaclustr non-prod env set env variable

`export IC_API_URL=https://api.dev.instaclustr.com`

For setting the URL back to prod use following:

`export IC_API_URL=https://api.instaclustr.com`

If the Azure resource group to be used is already present, it should be imported into terraform first:

`terraform import azurerm_resource_group.resource_group "/subscriptions/<subscription-id>/resourceGroups/<resource_group-id>"`
