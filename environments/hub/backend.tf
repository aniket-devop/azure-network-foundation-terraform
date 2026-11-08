# Remote state. The resource group and storage account must exist before a
# normal terraform init. They are not created by this root.
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "azurecloudtfstate01"
    container_name       = "tfstate"
    key                  = "hub.tfstate"
  }
}
