## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dps\_connection\_string | The generated dps connection string. | `string` | n/a | yes |
| environment | Development environment for resource; prod, non-prod, shared-services | `string` | n/a | yes |
| kube\_config | The generated kubeconfig string. | `string` | n/a | yes |
| kubelet\_object\_id | The User Assigned Managed Identity of the AKS Kubelet | `string` | n/a | yes |
| kusto\_cluster\_database | The generated name of the adx database | `string` | n/a | yes |
| kusto\_cluster\_uri | The generated uri for the adx connection string. | `string` | n/a | yes |
| name\_prefix | A short pre-defined text to identify the resource type | `string` | `"kv"` | no |
| random\_string\_result | The generated random string. | `string` | n/a | yes |
| region | Geographic Region resource will be deployed into | `string` | n/a | yes |
| resource\_group\_name | (Required) The Name of this Resource Group. | `string` | n/a | yes |
| tags | A map of tags to add to all resources | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| name | n/a |