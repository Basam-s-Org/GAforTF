output "key_vault_id" {
  value = module.pg_database_key_vault.key_vault_id
}

output "cluster_id" {
  value = module.pg_database_rdbms.cluster_id
}

output "default_user_password" {
  value = module.pg_database_rdbms.default_user_password
  sensitive = true
}
