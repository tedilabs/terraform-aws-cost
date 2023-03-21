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
  description = "(Optional) Whether you want Amazon Web Services to overwrite the previous version of each report or to deliver the report in addition to the previous versions. Valid values are `CREATE_NEW_REPORT`, `OVERWRITE_REPORT`."
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

variable "delivery_s3_region" {
  description = "(Optional) The region of the S3 bucket where AWS deliver the report. Defaults to current region."
  type        = string
  default     = null
}

variable "delivery_s3_bucket" {
  description = "(Required) The name of the S3 bucket where AWS deliver the report."
  type        = string
  nullable    = false
}

variable "delivery_s3_key_prefix" {
  description = "(Optional) The key prefix that AWS adds to the report name when AWS delivers the report. The key prefix can't include spaces."
  type        = string
  default     = ""
  nullable    = false
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
  description = "(Optional) A set of schema elements. Valid values are `RESOURCES`."
  type        = set(string)
  default     = []
  nullable    = false

  validation {
    condition = alltrue([
      for element in var.additional_schema_elements :
      contains(["RESOURCES"], element)
    ])
    error_message = "Valid values for each value of `additional_schema_elements` are `RESOURCES`."
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
