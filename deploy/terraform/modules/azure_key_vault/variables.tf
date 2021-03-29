###
# module variables
###

#common

variable "name_prefix" {
  description = "A short pre-defined text to identify the resource type"
  type        = string
  default     = "kv"
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

variable "kube_config" {
  description = "The generated kubeconfig string."
  type        = string
}

variable "dps_connection_string" {
  description = "The generated dps connection string."
  type        = string
}

variable "kusto_cluster_uri" {
  description = "The generated uri for the adx connection string."
  type        = string
}

variable "kusto_cluster_database" {
  description = "The generated name of the adx database"
  type        = string
}

variable "kubelet_object_id" {
  description = "The User Assigned Managed Identity of the AKS Kubelet"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(any)
  default     = {}
}