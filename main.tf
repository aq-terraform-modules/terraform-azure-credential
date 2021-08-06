locals {
  public_ssh_key  = var.type == "ssh" ? tls_private_key.linux_ssh_key[0].public_key_openssh : null
  private_ssh_key = var.type == "ssh" ? tls_private_key.linux_ssh_key[0].private_key_pem : null
  random_password = var.type == "password" ? random_password.random_password[0].result : null
}

resource "random_password" "random_password" {
  count   = var.type == "password" ? 1 : 0
  length  = var.length
  special = var.special
  min_special      = 1
  min_lower        = 1
  min_numeric      = 1
  min_upper        = 1
  override_special = var.override_special
}

resource "tls_private_key" "linux_ssh_key" {
  count = var.type == "ssh" ? 1 : 0
  algorithm = "RSA"
}

# Save private key file to local
/* resource "local_file" "private_key" {
  count        = length(tls_private_key.linux_ssh_key)
  content      = local.private_ssh_key
  filename     = "./creds/private_ssh_key.pem"
} */

resource "azurerm_key_vault_secret" "credential" {
  key_vault_id         = var.key_vault_id
  name                 = var.secret_name
  value                = var.type == "password" ? local.random_password : local.private_ssh_key
  
  tags = {
    Name = var.secret_name
    DeployDate  = replace(timestamp(), "/T.*$/", "") 
  }

  lifecycle {
    # Value should be ignore changes because our logic is to use the 1st init value only
    ignore_changes = [tags, value]
  }
}

resource "azurerm_storage_container" "credential_container" {
  count                 = length(tls_private_key.linux_ssh_key)
  name                  = "credential"
  storage_account_name  = var.storage_account_name
  container_access_type = var.container_access_type
}

resource "azurerm_storage_blob" "example" {
  count                  = length(tls_private_key.linux_ssh_key)
  name                   = "admin.pem"
  storage_account_name   = var.storage_account_name
  storage_container_name = azurerm_storage_container.credential_container[0].name
  type                   = "Block"
  source_content         = local.private_ssh_key
}
