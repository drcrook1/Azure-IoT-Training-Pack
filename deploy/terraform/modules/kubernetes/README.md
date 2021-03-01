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
| [azurerm_container_registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) |
| [azurerm_kubernetes_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) |
| [azurerm_kubernetes_cluster_node_pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) |
| [azurerm_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) |
| [azurerm_role_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) |
| [azurerm_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) |
| [azurerm_virtual_network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) |
| [random_string](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| address\_prefixes | (Required) The address prefixes to use for the subnet. | `list(string)` | n/a | yes |
| address\_space | (Required) The list of the ip address ranges for the vnet | `list(any)` | n/a | yes |
| environment | Development environment for resource; prod, non-prod, shared-services | `string` | n/a | yes |
| kubernetes\_version | Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade). | `string` | `null` | no |
| name\_prefix | A short pre-defined text to identify the resource type | `string` | `"aks"` | no |
| region | Geographic Region resource will be deployed into | `string` | n/a | yes |
| service\_name | Name of the application, service, or workload the resource group is housing. | `string` | `"aks-cluster"` | no |
| tags | A map of tags to add to all resources | `map(any)` | `{}` | no |
| vm\_size | (Required) The size of the Virtual Machine, such as Standard\_DS2\_v2. | `string` | `"Standard_DS2_v2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| fqdn | n/a |
| id | n/a |
| kube\_config\_client\_certificate | n/a |
| kube\_config\_client\_key | n/a |
| kube\_config\_cluster\_ca\_certificate | n/a |
| kube\_config\_host | n/a |
| kube\_config\_password | n/a |
| kube\_config\_raw | n/a |
| kube\_config\_username | n/a |
| name | n/a |
| node\_resource\_group | n/a |