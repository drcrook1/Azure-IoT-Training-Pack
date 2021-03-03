###
# module variables
###

#common

variable "service_name" {
  description = "Name of the application, service, or workload the resource group is housing."
  type        = string
  default     = "iot-backend"
}

variable "name_prefix" {
  description = "A short pre-defined text to identify the resource type"
  type        = string
  default     = "sql"
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

#sql server

variable "sql_version" {
  description = "(Required) The version for the new server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server)."
  type        = string
  default     = "12.0"
}

variable "administrator_login" {
  description = "(Required) The administrator login name for the new server. Changing this forces a new resource to be created."
  type        = string
}

variable "administrator_login_password" {
  description = "(Required) The password associated with the administrator_login user. Needs to comply with Azure's Password Policy"
  type        = string
}