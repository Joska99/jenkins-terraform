variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
  default     = "aks-rg-tf"
}
variable "location" {
  type        = string
  description = "Resources location in Azure"
  default     = "eastus"
}
variable "cluster_name" {
  type        = string
  default     = "joska-cluster-tf"
  description = "AKS name in Azure"
}
variable "kubernetes_version" {
  type        = string
  default     = "1.26.0"
  description = "Kubernetes version"
}
variable "system_node_count" {
  type        = number
  default     = 2
  description = "Number of AKS worker nodes"
}

variable "acr_name" {
  type        = string
  description = "ACR name"
  default     = "images4k8s"
}
variable "log_analytics_name" {
  type        = string
  description = "loganalytics name"
  default     = "eeboitflga"
}
variable "log_analytics_sku" {
  type        = string
  description = "log analytics price tier"
  default     = "PerGB2018"
}
