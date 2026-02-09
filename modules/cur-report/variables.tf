variable "name" {
  description = "(Required) The name of the report that you want to create. The name must be unique, is case sensitive, and can't include spaces. Limited to 256 characters."
  type        = string
  nullable    = false
}

variable "time_granularity" {
  description = "(Required) The frequency on which report data are measured and displayed. Valid values are `HOURLY`, `DAILY`, `MONTHLY`."
  type        = string
  nullable    = false

  validation {
    condition     = contains(["HOURLY", "DAILY", "MONTHLY"], var.time_granularity)
    error_message = "Valid values for `time_granularity` are `HOURLY`, `DAILY`, `MONTHLY`."
  }
}

variable "versioning_strategy" {
  description = "(Optional) Whether you want Amazon Web Services to overwrite the previous version of each report or to deliver the report in addition to the previous versions. Valid values are `CREATE_NEW_REPORT`, `OVERWRITE_REPORT`. Defaults to `OVERWRITE_REPORT`."
  type        = string
  default     = "OVERWRITE_REPORT"
  nullable    = false

  validation {
    condition     = contains(["CREATE_NEW_REPORT", "OVERWRITE_REPORT"], var.versioning_strategy)
    error_message = "Valid values for `versioning_strategy` are `CREATE_NEW_REPORT`, `OVERWRITE_REPORT`."
  }
}

variable "data_refresh_enabled" {
  description = "(Optional) Whether you want Amazon Web Services to update your reports after they have been finalized if Amazon Web Services detects charges related to previous months. These charges can include refunds, credits, or support fees. Defaults to `true`."
  type        = bool
  default     = true
  nullable    = false
}

variable "delivery_s3_bucket" {
  description = <<EOF
  (Required) The configuration of the S3 bucket where AWS deliver your reports. `delivery_s3_bucket` as defined below.
    (Required) `name` - The name of the S3 bucket where AWS deliver the report.
    (Optional) `key_prefix` - The key prefix that AWS adds to the report name when AWS delivers the report. The key prefix can't include spaces.
    (Optional) `region` - The region of the S3 bucket where AWS deliver the report. Defaults to current region.
  EOF
  type = object({
    name       = string
    key_prefix = optional(string)
    region     = optional(string)
  })
  nullable = false
}

variable "compression_format" {
  description = "(Optional) The compression format that AWS uses for the report. Valid values are `ZIP`, `GZIP`, `PARQUET`."
  type        = string
  default     = "GZIP"
  nullable    = false

  validation {
    condition     = contains(["ZIP", "GZIP", "PARQUET"], var.compression_format)
    error_message = "Valid values for `compression_format` are `ZIP`, `GZIP`, `PARQUET`."
  }
}

variable "additional_schema_elements" {
  description = "(Optional) A set of schema elements. Valid values are `MANUAL_DISCOUNT_COMPATIBILITY`, `RESOURCES`, `SPLIT_COST_ALLOCATION_DATA`."
  type        = set(string)
  default     = []
  nullable    = false

  validation {
    condition = alltrue([
      for element in var.additional_schema_elements :
      contains(["MANUAL_DISCOUNT_COMPATIBILITY", "RESOURCES", "SPLIT_COST_ALLOCATION_DATA"], element)
    ])
    error_message = "Valid values for each value of `additional_schema_elements` are `MANUAL_DISCOUNT_COMPATIBILITY`, `RESOURCES`, `SPLIT_COST_ALLOCATION_DATA`."
  }
}

variable "additional_artifacts" {
  description = "(Optional) A set of additional artifacts. Valid values are `REDSHIFT`, `QUICKSIGHT`, `ATHENA`. When `ATHENA` exists within `additional_artifacts`, no other artifact type can be declared and `versioning_strategy` must be `OVERWRITE_REPORT`."
  type        = set(string)
  default     = []
  nullable    = false

  validation {
    condition = alltrue([
      for artifact in var.additional_artifacts :
      contains(["REDSHIFT", "QUICKSIGHT", "ATHENA"], artifact)
    ])
    error_message = "Valid values for each value of `additional_artifacts` are `REDSHIFT`, `QUICKSIGHT`, `ATHENA`."
  }
}

variable "tags" {
  description = "(Optional) A map of tags to add to all resources."
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "module_tags_enabled" {
  description = "(Optional) Whether to create AWS Resource Tags for the module informations."
  type        = bool
  default     = true
  nullable    = false
}


###################################################
# Resource Group
###################################################

variable "resource_group" {
  description = <<EOF
  (Optional) A configurations of Resource Group for this module. `resource_group` as defined below.
    (Optional) `enabled` - Whether to create Resource Group to find and group AWS resources which are created by this module. Defaults to `true`.
    (Optional) `name` - The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. If not provided, a name will be generated using the module name and instance name.
    (Optional) `description` - The description of Resource Group. Defaults to `Managed by Terraform.`.
  EOF
  type = object({
    enabled     = optional(bool, true)
    name        = optional(string, "")
    description = optional(string, "Managed by Terraform.")
  })
  default  = {}
  nullable = false
}
