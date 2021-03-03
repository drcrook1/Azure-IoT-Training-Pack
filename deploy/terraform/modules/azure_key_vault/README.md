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
| [azurerm_client_config](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) |
| [azurerm_key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) |
| [azurerm_key_vault_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) |
| [random_string](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | Development environment for resource; prod, non-prod, shared-services | `string` | n/a | yes |
| name\_prefix | A short pre-defined text to identify the resource type | `string` | `"kv"` | no |
| random\_string\_result | The generated random string. | `string` | n/a | yes |
| region | Geographic Region resource will be deployed into | `string` | n/a | yes |
| resource\_group\_name | (Required) The Name of this Resource Group. | `string` | n/a | yes |
| service\_name | Name of the application, service, or workload the resource group is housing. | `string` | `"iot-keyvault"` | no |
| tags | A map of tags to add to all resources | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| sql\_password | n/a |