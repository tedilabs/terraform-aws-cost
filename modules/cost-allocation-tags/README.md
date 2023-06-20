# cost-allocation-tags

This module creates following resources.

- `aws_ce_cost_allocation_tag`

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.30 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.34.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cur_report_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cur_report_definition) | resource |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_delivery_s3_bucket"></a> [delivery\_s3\_bucket](#input\_delivery\_s3\_bucket) | (Required) The configuration for offering of the reservation. `offering` as defined below.<br>    (Required) `name` - The name of the S3 bucket where AWS deliver the report.<br>    (Optional) `key_prefix` -The key prefix that AWS adds to the report name when AWS delivers the report. The key prefix can't include spaces.<br>    (Optional) `region` - The region of the S3 bucket where AWS deliver the report. Defaults to current region. | <pre>object({<br>    name       = string<br>    key_prefix = optional(string)<br>    region     = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the report that you want to create. The name must be unique, is case sensitive, and can't include spaces. Limited to 256 characters. | `string` | n/a | yes |
| <a name="input_time_granularity"></a> [time\_granularity](#input\_time\_granularity) | (Required) The frequency on which report data are measured and displayed. Valid values are `HOURLY`, `DAILY`, `MONTHLY`. | `string` | n/a | yes |
| <a name="input_additional_artifacts"></a> [additional\_artifacts](#input\_additional\_artifacts) | (Optional) A set of additional artifacts. Valid values are `REDSHIFT`, `QUICKSIGHT`, `ATHENA`. When `ATHENA` exists within `additional_artifacts`, no other artifact type can be declared and `versioning_strategy` must be `OVERWRITE_REPORT`. | `set(string)` | `[]` | no |
| <a name="input_additional_schema_elements"></a> [additional\_schema\_elements](#input\_additional\_schema\_elements) | (Optional) A set of schema elements. Valid values are `RESOURCES`. | `set(string)` | `[]` | no |
| <a name="input_compression_format"></a> [compression\_format](#input\_compression\_format) | (Optional) The compression format that AWS uses for the report. Valid values are `ZIP`, `GZIP`, `PARQUET`. | `string` | `"GZIP"` | no |
| <a name="input_data_refresh_enabled"></a> [data\_refresh\_enabled](#input\_data\_refresh\_enabled) | (Optional) Whether you want Amazon Web Services to update your reports after they have been finalized if Amazon Web Services detects charges related to previous months. These charges can include refunds, credits, or support fees. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_versioning_strategy"></a> [versioning\_strategy](#input\_versioning\_strategy) | (Optional) Whether you want Amazon Web Services to overwrite the previous version of each report or to deliver the report in addition to the previous versions. Valid values are `CREATE_NEW_REPORT`, `OVERWRITE_REPORT`. | `string` | `"OVERWRITE_REPORT"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_additional_artifacts"></a> [additional\_artifacts](#output\_additional\_artifacts) | A set of additional artifacts. |
| <a name="output_additional_schema_elements"></a> [additional\_schema\_elements](#output\_additional\_schema\_elements) | A set of schema elements. |
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the report. |
| <a name="output_compression_format"></a> [compression\_format](#output\_compression\_format) | The compression format that AWS uses for the report. |
| <a name="output_data_refresh_enabled"></a> [data\_refresh\_enabled](#output\_data\_refresh\_enabled) | Whether you want Amazon Web Services to update your reports after they have been finalized if Amazon Web Services detects charges related to previous months. |
| <a name="output_delivery_s3_bucket"></a> [delivery\_s3\_bucket](#output\_delivery\_s3\_bucket) | The configuration of the S3 bucekt where AWS deliver the report.<br>    `name` - The name of the S3 bucket where AWS deliver the report.<br>    `key_prefix` - The key prefix that AWS adds to the report name when AWS delivers the report.<br>    `region` - The region of the S3 bucket where AWS deliver the report. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the report. |
| <a name="output_name"></a> [name](#output\_name) | The name of the report. |
| <a name="output_time_granularity"></a> [time\_granularity](#output\_time\_granularity) | The frequency on which report data are measured and displayed |
| <a name="output_versioning_strategy"></a> [versioning\_strategy](#output\_versioning\_strategy) | Whether you want Amazon Web Services to overwrite the previous version of each report or to deliver the report in addition to the previous versions. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
