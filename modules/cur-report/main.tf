locals {
  metadata = {
    package = "terraform-aws-cost"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = var.name
  }
  module_tags = var.module_tags_enabled ? {
    "module.terraform.io/package"   = local.metadata.package
    "module.terraform.io/version"   = local.metadata.version
    "module.terraform.io/name"      = local.metadata.module
    "module.terraform.io/full-name" = "${local.metadata.package}/${local.metadata.module}"
    "module.terraform.io/instance"  = local.metadata.name
  } : {}
}

data "aws_region" "this" {}

locals {
  default_region = data.aws_region.this.region

  format = {
    "ZIP"     = "textORcsv"
    "GZIP"    = "textORcsv"
    "PARQUET" = "Parquet"
  }
  compression = {
    "ZIP"     = "ZIP"
    "GZIP"    = "GZIP"
    "PARQUET" = "Parquet"
  }
}


###################################################
# Report of CUR (Cost and Usage Report)
###################################################

resource "aws_cur_report_definition" "this" {
  report_name = var.name

  ## Delivery Options
  time_unit              = var.time_granularity
  report_versioning      = var.versioning_strategy
  refresh_closed_reports = var.data_refresh_enabled

  ## Delivery Destination
  s3_bucket = var.delivery_s3_bucket.name
  s3_prefix = var.delivery_s3_bucket.key_prefix
  s3_region = coalesce(var.delivery_s3_bucket.region, local.default_region)

  ## Content
  format                     = local.format[var.compression_format]
  compression                = local.compression[var.compression_format]
  additional_schema_elements = var.additional_schema_elements
  additional_artifacts       = var.additional_artifacts

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}
