# savings-plan

This module creates following resources.

- `aws_savingsplans_savings_plan`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.38 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.38.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.12.0 |

## Resources

| Name | Type |
|------|------|
| [aws_savingsplans_savings_plan.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/savingsplans_savings_plan) | resource |
| [aws_savingsplans_offerings.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/savingsplans_offerings) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_commitment"></a> [commitment](#input\_commitment) | (Required) The hourly commitment, in USD. This is the amount you commit to pay per hour, regardless of actual usage. | `number` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) The customer-specified identifier to track this savings plan. Only used for `Name` resource tag. | `string` | n/a | yes |
| <a name="input_offering"></a> [offering](#input\_offering) | (Required) The configuration for offering of the savings plan. `offering` as defined below.<br/>    (Optional) `id` - The unique identifier for the savings plan offering. If specified, the other parameters in `offering` will be ignored and the offering with this ID will be used for purchasing the savings plan.<br/>    (Optional) `plan` - A plan type of the savings plan. Valid values are `Compute`, `EC2Instance`, `SageMaker`, `Database`.<br/>    (Optional) `type` - The offering type of this savings plan. Valid values are `NO_UPFRONT`, `PARTIAL_UPFRONT`, `ALL_UPFRONT`.<br/>    (Optional) `duration` - The duration of the reservation in seconds. Valid values are `31536000`, `94608000`.<br/>      (Optional) `region` - The region of the savings plan. Only required for `EC2Instance` savings plans. | <pre>object({<br/>    id       = optional(string)<br/>    plan     = optional(string)<br/>    type     = optional(string)<br/>    duration = optional(number)<br/>    region   = optional(string)<br/>  })</pre> | n/a | yes |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_purchase_at"></a> [purchase\_at](#input\_purchase\_at) | (Optional) The time at which to purchase the Savings Plan, in UTC format (YYYY-MM-DDTHH:MM:SSZ). If not specified, the plan is purchased immediately. Plans with a future purchase time are placed in queued state and can be deleted before they become active. | `string` | `null` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | (Optional) A configurations of Resource Group for this module. `resource_group` as defined below.<br/>    (Optional) `enabled` - Whether to create Resource Group to find and group AWS resources which are created by this module. Defaults to `true`.<br/>    (Optional) `name` - The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. If not provided, a name will be generated using the module name and instance name.<br/>    (Optional) `description` - The description of Resource Group. Defaults to `Managed by Terraform.`. | <pre>object({<br/>    enabled     = optional(bool, true)<br/>    name        = optional(string, "")<br/>    description = optional(string, "Managed by Terraform.")<br/>  })</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_upfront_payment_amount"></a> [upfront\_payment\_amount](#input\_upfront\_payment\_amount) | (Optional) The up-front payment amount. This is a whole number between 50 and 99 percent of the total value of the Savings Plan. This parameter is only supported if the payment option is `PARTIAL_UPFRONT`. | `number` | `0` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the Savings Plan. |
| <a name="output_commitment"></a> [commitment](#output\_commitment) | The hourly commitment, in USD. This is the amount you commit to pay per hour, regardless of actual usage. |
| <a name="output_end_at"></a> [end\_at](#output\_end\_at) | The end time of the Savings Plan. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Savings Plan. |
| <a name="output_name"></a> [name](#output\_name) | The customer-specified identifier to track this savings plan. |
| <a name="output_offering"></a> [offering](#output\_offering) | The offering information for the Savings Plan.<br/>    `id` - The unique identifier for the Savgins Plan.<br/>    `plan` - The plan type of the Savings Plan.<br/>    `type` - The offering type of this Savings Plan.<br/>    `description` - The description of the Savings Plan.<br/>    `duration` - The duration of the Savings Plan in seconds.<br/>    `product_types` - The product types applicable to the Savings Plan.<br/>    `currency_code` - The currency code of the Savings Plan.<br/>    `ec2` - The EC2-specific attributes of the Savings Plan. Only present for `EC2Instance` Savings Plans. Contains the following attributes:<br/>      `instance_family` - The instance family of the EC2Instance Savings Plan, for example `m5`. |
| <a name="output_purchase_at"></a> [purchase\_at](#output\_purchase\_at) | The purchase time of the Savings Plan. |
| <a name="output_recurring_payment_amount"></a> [recurring\_payment\_amount](#output\_recurring\_payment\_amount) | The recurring payment amount. |
| <a name="output_resource_group"></a> [resource\_group](#output\_resource\_group) | The resource group created to manage resources in this module. |
| <a name="output_returnable_until"></a> [returnable\_until](#output\_returnable\_until) | The time until when a return for the Savings Plan can be requested. If the Savings Plan is not returnable, the field reflects the Savings Plans start time. |
| <a name="output_start_at"></a> [start\_at](#output\_start\_at) | The start time of the Savings Plan. |
| <a name="output_state"></a> [state](#output\_state) | The current state of the Savings Plan. |
| <a name="output_upfront_payment_amount"></a> [upfront\_payment\_amount](#output\_upfront\_payment\_amount) | The up-front payment amount. |
<!-- END_TF_DOCS -->
