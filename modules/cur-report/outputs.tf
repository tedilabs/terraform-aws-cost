output "arn" {
  description = "The ARN of the report."
  value       = aws_cur_report_definition.this.arn
}

output "name" {
  description = "The name of the report."
  value       = aws_cur_report_definition.this.report_name
}
