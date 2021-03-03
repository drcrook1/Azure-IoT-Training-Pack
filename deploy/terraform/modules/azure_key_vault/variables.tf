###
# module variables
###

#common

variable "service_name" {
  description = "Name of the application, service, or workload the resource group is housing."
  type        = string
  default     = "iot-keyvault"
}

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

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(any)
  default     = {}
}