output "value" {
  value = azurerm_key_vault_secret.credential.value
  sensitive   = true
  description = "Private SSH Key or Random Password"
}

output "ssh_public_key" {
  value = local.public_ssh_key
  sensitive = true
  description = "Public SSH Key that can be used as input to an VM"
}
