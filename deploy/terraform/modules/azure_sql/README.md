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
| [azurerm_sql_database](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sql_database) |
| [azurerm_sql_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sql_server) |
| [random_string](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| administrator\_login | (Required) The administrator login name for the new server. Changing this forces a new resource to be created. | `string` | n/a | yes |
| administrator\_login\_password | (Required) The password associated with the administrator\_login user. Needs to comply with Azure's Password Policy | `string` | n/a | yes |
| environment | Development environment for resource; prod, non-prod, shared-services | `string` | n/a | yes |
| name\_prefix | A short pre-defined text to identify the resource type | `string` | `"sql"` | no |
| random\_string\_result | The generated random string. | `string` | n/a | yes |
| region | Geographic Region resource will be deployed into | `string` | n/a | yes |
| resource\_group\_name | (Required) The Name of this Resource Group. | `string` | n/a | yes |
| service\_name | Name of the application, service, or workload the resource group is housing. | `string` | `"iot-backend"` | no |
| sql\_version | (Required) The version for the new server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server). | `string` | `"12.0"` | no |
| tags | A map of tags to add to all resources | `map(any)` | `{}` | no |

## Outputs

No output.