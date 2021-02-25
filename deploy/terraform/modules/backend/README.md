## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |
| random | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [azurerm_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) |
| [azurerm_sql_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sql_server) |
| [azurerm_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) |
| [random_string](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_replication\_type | (Required) Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS and ZRS. | `string` | `"LRS"` | no |
| account\_tier | (Required) Defines the Tier to use for this storage account. Valid options are Standard and Premium. For FileStorage accounts only Premium is valid. Changing this forces a new resource to be created. | `string` | `"Standard"` | no |
| administrator\_login | (Required) The administrator login name for the new server. Changing this forces a new resource to be created. | `string` | n/a | yes |
| administrator\_login\_password | (Required) The password associated with the administrator\_login user. Needs to comply with Azure's Password Policy | `string` | n/a | yes |
| environment | Development environment for resource; prod, non-prod, shared-services | `string` | n/a | yes |
| name\_prefix | A short pre-defined text to identify the resource type | `string` | `"ftaiot"` | no |
| region | Geographic Region resource will be deployed into | `string` | n/a | yes |
| service\_name | Name of the application, service, or workload the resource group is housing. | `string` | `"iot-backend"` | no |
| tags | A map of tags to add to all resources | `map(any)` | `{}` | no |
| sql_version | (Required) The version for the new server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server). | `string` | `"12.0"` | no |

## Outputs

No output.