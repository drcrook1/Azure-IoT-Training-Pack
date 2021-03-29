## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | Development environment for resource; prod, non-prod, shared-services | `string` | n/a | yes |
| iothub\_consumer\_group | (Required) Specifies the IotHub consumer group this data connection will use for ingestion. Changing this forces a new resource to be created. | `string` | n/a | yes |
| iothub\_id | (Required) Specifies the resource id of the IotHub this data connection will use for ingestion. Changing this forces a new resource to be created. | `string` | n/a | yes |
| iothub\_shared\_access\_policy\_name | (Required) Specifies the IotHub Shared Access Policy this data connection will use for ingestion, which must have read permission. Changing this forces a new resource to be created. | `string` | n/a | yes |
| name\_prefix | A short pre-defined text to identify the resource type | `string` | `"dec"` | no |
| random\_string\_result | The generated random string. | `string` | n/a | yes |
| region | Geographic Region resource will be deployed into | `string` | n/a | yes |
| resource\_group\_name | (Required) The Name of this Resource Group. | `string` | n/a | yes |
| sku\_capacity | (Optional) Specifies the node count for the cluster. Boundaries depend on the sku name. | `number` | `1` | no |
| sku\_name | (Required) The name of the SKU. Valid values are: Dev(No SLA)\_Standard\_D11\_v2, Dev(No SLA)\_Standard\_E2a\_v4, Standard\_D11\_v2, Standard\_D12\_v2, Standard\_D13\_v2, Standard\_D14\_v2, Standard\_DS13\_v2+1TB\_PS, Standard\_DS13\_v2+2TB\_PS, Standard\_DS14\_v2+3TB\_PS, Standard\_DS14\_v2+4TB\_PS, Standard\_E16as\_v4+3TB\_PS, Standard\_E16as\_v4+4TB\_PS, Standard\_E16a\_v4, Standard\_E2a\_v4, Standard\_E4a\_v4, Standard\_E8as\_v4+1TB\_PS, Standard\_E8as\_v4+2TB\_PS, Standard\_E8a\_v4, Standard\_L16s, Standard\_L4s and Standard\_L8s | `string` | `"Dev(No SLA)_Standard_D11_v2"` | no |
| tags | A map of tags to add to all resources | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| data\_explorer\_cluster\_uri | n/a |
| data\_explorer\_data\_ingestion\_uri | n/a |
| data\_explorer\_id | n/a |
| database\_name | n/a |