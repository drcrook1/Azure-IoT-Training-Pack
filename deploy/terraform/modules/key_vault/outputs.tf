output "sql_password" {
  value = random_string.key_vault_secret.result
}