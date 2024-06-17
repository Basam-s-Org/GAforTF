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
    dynamic "azure_settings" {
      # Only write out an azure_settings block if the dc_storage_network
      # variable is set
      for_each = var.dc_storage_network != "" ? range(1) : []
      content {
        storage_network = var.dc_storage_network
      }
    }
    client_to_cluster_encryption = var.client_to_cluster_encryption
    cloud_provider               = var.cloud_provider
    region                       = var.cloud_provider_region
    name                         = var.dc_name
    provider_account_name        = var.provider_account_name 

    inter_data_centre_replication {
      is_primary_data_centre = true
    }

    intra_data_centre_replication {
      replication_mode = var.db_replication_mode
    }

    network = var.dc_network


    # Using ANF storage; provisioned automatically
    node_size       = var.db_node_size
    number_of_nodes = var.db_number_of_nodes

  }

  synchronous_mode_strict = var.synchronous_mode_strict
  private_network_cluster = var.private_network_cluster
  sla_tier                = var.sla_tier
}
