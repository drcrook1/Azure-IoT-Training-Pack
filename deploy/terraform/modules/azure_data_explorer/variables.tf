###
# module variables
###

#common

variable "name_prefix" {
  description = "A short pre-defined text to identify the resource type"
  type        = string
  default     = "dec"
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

# ade cluster

variable "sku_name" {
  description = " (Required) The name of the SKU. Valid values are: Dev(No SLA)_Standard_D11_v2, Dev(No SLA)_Standard_E2a_v4, Standard_D11_v2, Standard_D12_v2, Standard_D13_v2, Standard_D14_v2, Standard_DS13_v2+1TB_PS, Standard_DS13_v2+2TB_PS, Standard_DS14_v2+3TB_PS, Standard_DS14_v2+4TB_PS, Standard_E16as_v4+3TB_PS, Standard_E16as_v4+4TB_PS, Standard_E16a_v4, Standard_E2a_v4, Standard_E4a_v4, Standard_E8as_v4+1TB_PS, Standard_E8as_v4+2TB_PS, Standard_E8a_v4, Standard_L16s, Standard_L4s and Standard_L8s"
  type        = string
  default     = "Dev(No SLA)_Standard_D11_v2"
}

variable "sku_capacity" {
  description = "(Optional) Specifies the node count for the cluster. Boundaries depend on the sku name."
  type        = number
  default     = 1
}

# ade iothub data connection

variable "iothub_id" {
  description = "(Required) Specifies the resource id of the IotHub this data connection will use for ingestion. Changing this forces a new resource to be created."
  type        = string
}

variable "iothub_consumer_group" {
  description = "(Required) Specifies the IotHub consumer group this data connection will use for ingestion. Changing this forces a new resource to be created."
  type        = string
}

variable "iothub_shared_access_policy_name" {
  description = "(Required) Specifies the IotHub Shared Access Policy this data connection will use for ingestion, which must have read permission. Changing this forces a new resource to be created."
  type        = string
}