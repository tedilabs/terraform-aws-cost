# cur-report

This module creates following resources.

- `aws_cur_report_definition`

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
| <a name="input_delivery_s3_bucket"></a> [delivery\_s3\_bucket](#input\_delivery\_s3\_bucket) | (Required) The name of the S3 bucket where AWS deliver the report. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the report that you want to create. The name must be unique, is case sensitive, and can't include spaces. Limited to 256 characters. | `string` | n/a | yes |
| <a name="input_time_granularity"></a> [time\_granularity](#input\_time\_granularity) | (Required) The frequency on which report data are measured and displayed. Valid values are `HOURLY`, `DAILY`, `MONTHLY`. | `string` | n/a | yes |
| <a name="input_additional_artifacts"></a> [additional\_artifacts](#input\_additional\_artifacts) | (Optional) A set of additional artifacts. Valid values are `REDSHIFT`, `QUICKSIGHT`, `ATHENA`. When `ATHENA` exists within `additional_artifacts`, no other artifact type can be declared and `versioning_strategy` must be `OVERWRITE_REPORT`. | `set(string)` | `[]` | no |
| <a name="input_additional_schema_elements"></a> [additional\_schema\_elements](#input\_additional\_schema\_elements) | (Optional) A set of schema elements. Valid values are `RESOURCES`. | `set(string)` | `[]` | no |
| <a name="input_compression_format"></a> [compression\_format](#input\_compression\_format) | (Optional) The compression format that AWS uses for the report. Valid values are `ZIP`, `GZIP`, `PARQUET`. | `string` | `"GZIP"` | no |
| <a name="input_data_refresh_enabled"></a> [data\_refresh\_enabled](#input\_data\_refresh\_enabled) | (Optional) Whether you want Amazon Web Services to update your reports after they have been finalized if Amazon Web Services detects charges related to previous months. These charges can include refunds, credits, or support fees. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_delivery_s3_key_prefix"></a> [delivery\_s3\_key\_prefix](#input\_delivery\_s3\_key\_prefix) | (Optional) The key prefix that AWS adds to the report name when AWS delivers the report. The key prefix can't include spaces. | `string` | `""` | no |
| <a name="input_delivery_s3_region"></a> [delivery\_s3\_region](#input\_delivery\_s3\_region) | (Optional) The region of the S3 bucket where AWS deliver the report. Defaults to current region. | `string` | `null` | no |
| <a name="input_versioning_strategy"></a> [versioning\_strategy](#input\_versioning\_strategy) | (Optional) Whether you want Amazon Web Services to overwrite the previous version of each report or to deliver the report in addition to the previous versions. Valid values are `CREATE_NEW_REPORT`, `OVERWRITE_REPORT`. | `string` | `"OVERWRITE_REPORT"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the report. |
| <a name="output_name"></a> [name](#output\_name) | The name of the report. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
