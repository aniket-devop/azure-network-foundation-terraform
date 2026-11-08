data "azurerm_client_config" "current" {}

data "terraform_remote_state" "hub" {
  backend = "azurerm"

  config = {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "azurecloudtfstate01"
    container_name       = "tfstate"
    key                  = "hub.tfstate"
  }
}
