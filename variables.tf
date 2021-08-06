variable "length" {
  default = 16
}
variable "type"{
  description = "Type for creds to be created"
  # Should be:
  #   * 'password' : Create random password for windows
  #   * 'ssh' : Create random ssh public and private key for linux
}

variable "secret_name" {
  description = "Name for secret to be saved"
  
}

variable "key_vault_id" {
  description = "Keyvault ID to be passed from workspace"
}

variable "special" {
  type = bool
  default = true
  description = "Enable special characters when generate password"
}

variable "override_special" {
  description = " set of special characters allowed in password"
  default     = "!()*-@^_"
}

variable "storage_account_name" {
  description = "Storage account to upload keypem"
}
