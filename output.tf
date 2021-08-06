output "value" {
    value = azurerm_key_vault_secret.credential.value
    sensitive   = true
}

output "ssh_public_key" {
  value = local.public_ssh_key
  sensitive = true
}
