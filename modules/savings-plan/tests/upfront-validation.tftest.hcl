mock_provider "aws" {
  mock_data "aws_savingsplans_offerings" {
    defaults = {
      offerings = [{
        offering_id      = "11111111-1111-1111-1111-111111111111"
        plan_type        = "Compute"
        payment_option   = "Partial Upfront"
        duration_seconds = 31536000
      }]
    }
  }
}
mock_provider "telemetry" {}

variables {
  name       = "upfront-validation-test"
  commitment = 1
  offering = {
    plan     = "Compute"
    type     = "PARTIAL_UPFRONT"
    duration = 31536000
  }
  telemetry = {
    enabled = false
  }
  resource_group = {
    enabled = false
  }
}

run "partial_lower_boundary" {
  command = plan
  variables {
    upfront_payment_amount = 4380
  }
  assert {
    condition     = aws_savingsplans_savings_plan.this.upfront_payment_amount != null
    error_message = "Valid Partial Upfront amounts must be accepted."
  }
}

run "partial_upper_boundary" {
  command = plan
  variables {
    upfront_payment_amount = 8672
  }
  assert {
    condition     = aws_savingsplans_savings_plan.this.upfront_payment_amount != null
    error_message = "Valid Partial Upfront amounts must be accepted."
  }
}

run "partial_below_half" {
  command = plan
  variables {
    upfront_payment_amount = 4379
  }
  expect_failures = [aws_savingsplans_savings_plan.this]
}

run "partial_above_99_percent" {
  command = plan
  variables {
    upfront_payment_amount = 8673
  }
  expect_failures = [aws_savingsplans_savings_plan.this]
}

run "partial_fractional" {
  command = plan
  variables {
    upfront_payment_amount = 5000.5
  }
  expect_failures = [aws_savingsplans_savings_plan.this]
}

run "one_year_above_total" {
  command = plan
  variables {
    upfront_payment_amount = 10000
  }
  expect_failures = [aws_savingsplans_savings_plan.this]
}

run "three_year_lower_boundary" {
  command = plan
  variables {
    upfront_payment_amount = 13140
  }
  override_data {
    target = data.aws_savingsplans_offerings.this[0]
    values = {
      offerings = [{
        offering_id      = "11111111-1111-1111-1111-111111111111"
        plan_type        = "Compute"
        payment_option   = "Partial Upfront"
        duration_seconds = 94608000
      }]
    }
  }
}

run "no_upfront_nonzero" {
  command = plan
  variables {
    upfront_payment_amount = 1
  }
  override_data {
    target = data.aws_savingsplans_offerings.this[0]
    values = {
      offerings = [{
        offering_id      = "11111111-1111-1111-1111-111111111111"
        plan_type        = "Compute"
        payment_option   = "No Upfront"
        duration_seconds = 31536000
      }]
    }
  }
  expect_failures = [aws_savingsplans_savings_plan.this]
}

run "no_upfront_explicit_zero" {
  command = plan
  variables {
    upfront_payment_amount = 0
  }
  override_data {
    target = data.aws_savingsplans_offerings.this[0]
    values = {
      offerings = [{
        offering_id      = "11111111-1111-1111-1111-111111111111"
        plan_type        = "Compute"
        payment_option   = "No Upfront"
        duration_seconds = 31536000
      }]
    }
  }
  expect_failures = [aws_savingsplans_savings_plan.this]
}

run "all_upfront_total" {
  command = plan
  variables {
    upfront_payment_amount = 8760
  }
  override_data {
    target = data.aws_savingsplans_offerings.this[0]
    values = {
      offerings = [{
        offering_id      = "11111111-1111-1111-1111-111111111111"
        plan_type        = "Compute"
        payment_option   = "All Upfront"
        duration_seconds = 31536000
      }]
    }
  }
}

run "id_only_import_amount" {
  command = plan
  variables {
    offering = {
      id = "11111111-1111-1111-1111-111111111111"
    }
    upfront_payment_amount = 237571.2
    commitment             = 9.04
  }
  assert {
    condition     = length(data.aws_savingsplans_offerings.this) == 0
    error_message = "ID-only imports must not look up historical offerings to validate metadata."
  }
}

run "all_upfront_above_one_year_total" {
  command = plan
  variables {
    upfront_payment_amount = 10000
  }
  override_data {
    target = data.aws_savingsplans_offerings.this[0]
    values = {
      offerings = [{
        offering_id      = "11111111-1111-1111-1111-111111111111"
        plan_type        = "Compute"
        payment_option   = "All Upfront"
        duration_seconds = 31536000
      }]
    }
  }
  expect_failures = [aws_savingsplans_savings_plan.this]
}

run "no_upfront_null" {
  command = plan
  override_data {
    target = data.aws_savingsplans_offerings.this[0]
    values = {
      offerings = [{
        offering_id      = "11111111-1111-1111-1111-111111111111"
        plan_type        = "Compute"
        payment_option   = "No Upfront"
        duration_seconds = 31536000
      }]
    }
  }
}

run "partial_missing_amount" {
  command         = plan
  expect_failures = [aws_savingsplans_savings_plan.this]
}
