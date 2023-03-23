output "arn" {
  description = "The ARN of the report."
  value       = aws_cur_report_definition.this.arn
}

output "id" {
  description = "The ID of the report."
  value       = aws_cur_report_definition.this.id
}

output "name" {
  description = "The name of the report."
  value       = aws_cur_report_definition.this.report_name
}

output "time_granularity" {
  description = "The frequency on which report data are measured and displayed"
  value       = aws_cur_report_definition.this.time_unit
}

output "versioning_strategy" {
  description = "Whether you want Amazon Web Services to overwrite the previous version of each report or to deliver the report in addition to the previous versions."
  value       = aws_cur_report_definition.this.report_versioning
}

output "data_refresh_enabled" {
  description = "Whether you want Amazon Web Services to update your reports after they have been finalized if Amazon Web Services detects charges related to previous months."
  value       = aws_cur_report_definition.this.refresh_closed_reports
}

output "delivery_s3_bucket" {
  description = <<EOF
  The configuration of the S3 bucekt where AWS deliver the report.
    `name` - The name of the S3 bucket where AWS deliver the report.
    `key_prefix` - The key prefix that AWS adds to the report name when AWS delivers the report.
    `region` - The region of the S3 bucket where AWS deliver the report.
  EOF
  value = {
    name       = aws_cur_report_definition.this.s3_bucket
    key_prefix = aws_cur_report_definition.this.s3_prefix
    region     = aws_cur_report_definition.this.s3_region
  }
}

output "compression_format" {
  description = "The compression format that AWS uses for the report."
  value       = var.compression_format
}

output "additional_schema_elements" {
  description = "A set of schema elements."
  value       = aws_cur_report_definition.this.additional_schema_elements
}

output "additional_artifacts" {
  description = "A set of additional artifacts."
  value       = aws_cur_report_definition.this.additional_artifacts
}
