data "azurerm_key_vault" "kv_id" {
  name                = "nt-kv-vault"
  resource_group_name = "rg-beni"
}

resource "azurerm_key_vault_secret" "bond_007" {
  name         = var.secret_name
  value        = var.secret_value
  key_vault_id = data.azurerm_key_vault.kv_id.id
}