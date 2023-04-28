# azure provider and version
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"

    }
  }
  # ######################
  # # BACKEND FOR .TFSTATE
  # ######################
  # backend "azurerm" {
  #   resource_group_name  = "name-rg"
  #   storage_account_name = "sa-name"
  #   container_name       = "c-name"
  #   key                  = "terraform.tfstate"
  # }
}

provider "azurerm" {
  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  version         = "3.45.0"
  features {}
}



module "aks" {
  source = "./ias"
}
