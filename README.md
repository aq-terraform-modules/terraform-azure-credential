# terraform-azure-credential

This module generates random password and linux ssh key and can be used to generate password/keys and push them to Azure Key Vault as well as create an admin.pem inside a storage account container

## Usage Example ( calling this module)**
```terraform
data "azurerm_key_vault" "myvault" {
  name                = var.keyvault_name
  resource_group_name = var.keyvault_rg_name
}


module "windows-password" {
  source  = "git::https://github.com/aq-terraform-modules/terraform-azure-credential.git?ref=dev"
  type                = "password"
  secret_name         = "windows-admin-password"
  key_vault_id        = data.azurerm_key_vault.myvault.id
}

module "linux-ssh-key" {
  source  = "git::https://github.com/aq-terraform-modules/terraform-azure-credential.git?ref=dev"
  type                  = "ssh"
  secret_name           = "linux-user-private-ssh-key"
  storage_account_name  = var.storage_account_name
  key_vault_id          = data.azurerm_key_vault.myvault.id
}
```

### Git repo
| Protocol | URL                                                                                                          |
| -------- | ----------------------------------------------------------------------------------------------------------   |
| HTTPS    | `git::https://github.com/aq-terraform-modules/terraform-azure-credential.git?ref=<version>`  |
| SSH      | `git::ssh://git@github.com:aq-terraform-modules/terraform-azure-credential.git?ref=<version>`|
