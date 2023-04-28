########################
# CREATE RESOURCES GROUP
########################
resource "azurerm_resource_group" "aks-rg" {
  name     = var.resource_group_name
  location = var.location
}

################
# CREATE CLUSTER
################
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  location            = var.location
  resource_group_name = azurerm_resource_group.aks-rg.name
  dns_prefix          = var.cluster_name

  default_node_pool {
    name                = "system"
    node_count          = var.system_node_count
    vm_size             = "Standard_DS2_v2"
    type                = "VirtualMachineScaleSets"
    enable_auto_scaling = false
  }
  identity {
    type = "SystemAssigned"
  }
  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "kubenet"
  }
  #########################
  # Attach log analytics
  #########################
  # oms_agent {
  #   log_analytics_workspace_id = azurerm_log_analytics_workspace.test.id
  # }
}
############
# CREATE ACR
############
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.aks-rg.name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false
}

##################
# CREATE LOG ANALITICS
##################
resource "azurerm_log_analytics_workspace" "test" {
  location            = var.location
  name                = var.log_analytics_name
  resource_group_name = azurerm_resource_group.aks-rg.name
  sku                 = var.log_analytics_sku
}
