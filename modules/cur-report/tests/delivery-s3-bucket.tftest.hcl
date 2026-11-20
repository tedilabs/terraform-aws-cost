mock_provider "aws" {
  mock_data "aws_region" {
    defaults = {
      region = "us-east-1"
    }
  }
}

mock_provider "telemetry" {}

variables {
  name             = "cur-test"
  time_granularity = "DAILY"
  telemetry = {
    enabled = false
  }
  resource_group = {
    enabled = false
  }
}

run "omitted_key_prefix" {
  command = plan
  variables {
    delivery_s3_bucket = {
      name = "cur-bucket"
    }
  }
  assert {
    condition     = aws_cur_report_definition.this.s3_prefix == ""
    error_message = "An omitted `key_prefix` must default to an empty prefix."
  }
}

run "explicit_key_prefix" {
  command = plan
  variables {
    delivery_s3_bucket = {
      name       = "cur-bucket"
      key_prefix = "cur/"
    }
  }
  assert {
    condition     = aws_cur_report_definition.this.s3_prefix == "cur/"
    error_message = "An explicit `key_prefix` must be passed unchanged."
  }
}
