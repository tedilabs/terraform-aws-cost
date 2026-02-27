# elasticache-reserved-instance

This module creates following resources.

- `aws_elasticache_reserved_cache_node`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.31 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.31.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.12.0 |

## Resources

| Name | Type |
|------|------|
| [aws_elasticache_reserved_cache_node.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_reserved_cache_node) | resource |
| [aws_elasticache_reserved_cache_node_offering.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/elasticache_reserved_cache_node_offering) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The customer-specified identifier to track this reservation. | `string` | n/a | yes |
| <a name="input_offering"></a> [offering](#input\_offering) | (Required) The configuration for offering of the reservation. `offering` as defined below.<br/>    (Required) `type` - The offering type of this reserved cache node. Valid values are `NO_UPFRONT`, `PARTIAL_UPFRONT`, `ALL_UPFRONT`.<br/>    (Required) `duration` - The duration of the reservation in years or seconds. Valid values are `1`, `3`.<br/>    (Required) `product` - The engine type for the reserved cache node. Valid values are `redis`, `valkey`, `memcached`.<br/>    (Required) `instance_type` - The cache node type for the reserved cache node, for example `cache.t4g.small`. Not all cache node types are available in all AWS Regions. | <pre>object({<br/>    type          = string<br/>    duration      = number<br/>    product       = string<br/>    instance_type = string<br/>  })</pre> | n/a | yes |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | (Optional) The number of cache instances to reserve. Defaults to `1`. | `number` | `1` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_region"></a> [region](#input\_region) | (Optional) The region in which to create the module resources. If not provided, the module resources will be created in the provider's configured region. | `string` | `null` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | (Optional) A configurations of Resource Group for this module. `resource_group` as defined below.<br/>    (Optional) `enabled` - Whether to create Resource Group to find and group AWS resources which are created by this module. Defaults to `true`.<br/>    (Optional) `name` - The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. If not provided, a name will be generated using the module name and instance name.<br/>    (Optional) `description` - The description of Resource Group. Defaults to `Managed by Terraform.`. | <pre>object({<br/>    enabled     = optional(bool, true)<br/>    name        = optional(string, "")<br/>    description = optional(string, "Managed by Terraform.")<br/>  })</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN for the reserved cache node. |
| <a name="output_id"></a> [id](#output\_id) | The unique identifier for the reservation. |
| <a name="output_instance_count"></a> [instance\_count](#output\_instance\_count) | The number of reserved cache nodes. |
| <a name="output_name"></a> [name](#output\_name) | The customer-specified identifier to track this reservation. |
| <a name="output_offering"></a> [offering](#output\_offering) | The offering information for the ElastiCache reserved cache node.<br/>    `id` - The unique identifier for the reservation offering.<br/>    `type` - The offering type of this reserved cache node.<br/>    `duration` - The duration of the reservation as an RFC3339 duration.<br/>    `product` - The engine type for the reserved cache node.<br/>    `instance_type` - The cache node type for the reserved cache node, for example `cache.t4g.small`.<br/>    `fixed_price` - The fixed price charged for this reserved cache node.<br/>    `usage_price` - The hourly price charged for this offering.<br/>    `recurring_price` - The recurring price charged to run this reserved cache node. |
| <a name="output_region"></a> [region](#output\_region) | The AWS region this module resources resides in. |
| <a name="output_resource_group"></a> [resource\_group](#output\_resource\_group) | The resource group created to manage resources in this module. |
| <a name="output_started_at"></a> [started\_at](#output\_started\_at) | The time the reservation started. |
| <a name="output_state"></a> [state](#output\_state) | The state of the reserved cache node. |
<!-- END_TF_DOCS -->
