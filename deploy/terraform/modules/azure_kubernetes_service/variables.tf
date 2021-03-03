#common

variable "service_name" {
  description = "Name of the application, service, or workload the resource group is housing."
  type        = string
  default     = "aks-cluster"
}

variable "name_prefix" {
  description = "A short pre-defined text to identify the resource type"
  type        = string
  default     = "aks"
}

variable "environment" {
  description = "Development environment for resource; prod, non-prod, shared-services"
  type        = string
}

variable "region" {
  description = "Geographic Region resource will be deployed into"
  type        = string
}

variable "resource_group_name" {
  description = "(Required) The Name of this Resource Group."
  type        = string
}

variable "random_string_result" {
  description = "The generated random string."
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(any)
  default     = {}
}

#vnet

variable "address_space" {
  description = "(Required) The list of the ip address ranges for the vnet"
  type        = list(any)
}

#subnet

variable "address_prefixes" {
  description = "(Required) The address prefixes to use for the subnet."
  type        = list(string)
}

#kubernetes_cluster

variable "kubernetes_version" {
  description = "Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade)."
  type        = string
  default     = null
}

variable "vm_size" {
  description = "(Required) The size of the Virtual Machine, such as Standard_DS2_v2."
  type        = string
  default     = "Standard_DS2_v2"
}