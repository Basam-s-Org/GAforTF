# Retrieve the current Azure client configuration
data "azurerm_client_config" "current" {}

# Define an Instaclustr PostgreSQL cluster resource
resource "instaclustr_postgresql_cluster_v2" "example" {
  name               = var.db_name
  postgresql_version = var.db_version
  extensions         = var.db_extensions

  data_centre {
    tag {
      key   = "key_vault_name"
      value = var.db_secret_kv
    }
    azure_settings {
      storage_network = var.storage_network  # Subnet for ANF storage
    }
    client_to_cluster_encryption = var.client_to_cluster_encryption
    cloud_provider               = var.cloud_provider
    name                         = var.dc_name
    provider_account_name        = var.provider_account_name 

    inter_data_centre_replication {
      is_primary_data_centre = true
    }

    intra_data_centre_replication {
      replication_mode = var.intra_dc_replication_mode
    }

    network = var.dc_network

    # Using ANF storage; provisioned automatically
    node_size       = var.node_size
    number_of_nodes = var.number_of_nodes 
    region          = var.dc_region
  }

  synchronous_mode_strict = var.synchronous_mode_strict
  private_network_cluster = var.private_network_cluster
  sla_tier                = var.sla_tier
}
