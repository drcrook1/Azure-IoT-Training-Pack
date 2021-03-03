## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14 |
| azurerm | >=2.49.0 |
| helm | >=2.0.0 |
| kubernetes | >=2.0.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >=2.49.0 |
| random | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| azure_data_explorer | ./modules/azure_data_explorer |  |
| azure_iot_hub | ./modules/azure_iot_hub |  |
| azure_key_vault | ./modules/azure_key_vault |  |
| azure_kubernetes_service | ./modules/azure_kubernetes_service |  |
| azure_sql | ./modules/azure_sql |  |

## Resources

| Name |
|------|
| [azurerm_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) |
| [random_string](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| address\_prefixes | (Required) The address prefixes to use for the subnet. | `list(string)` | n/a | yes |
| address\_space | (Required) The list of the ip address ranges for the vnet | `list(any)` | n/a | yes |
| administrator\_login | (Required) The administrator login name for the new server. Changing this forces a new resource to be created. | `string` | n/a | yes |
| environment | Development environment for resource; prod, non-prod, shared-services | `string` | n/a | yes |
| region | Geographic Region resource will be deployed into | `string` | n/a | yes |
| tags | A map of tags to add to all resources | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| client\_certificate | n/a |
| kube\_config | n/a |