mock_provider "aws" {
  mock_data "aws_savingsplans_offerings" {
    defaults = {
      offerings = [{
        offering_id      = "2cd228b1-cae4-4c6b-bad6-d3a26e4dff7c"
        plan_type        = "Database"
        payment_option   = "No Upfront"
        duration_seconds = 31536000
      }]
    }
  }
}

mock_provider "telemetry" {}

variables {
  name       = "offering-test"
  commitment = 1
  telemetry = {
    enabled = false
  }
  resource_group = {
    enabled = false
  }
}

run "explicit_id" {
  command = plan
  variables {
    offering = {
      id = "1cf796fe-9b14-45d4-b35f-fc9448e913b1"
    }
  }
  assert {
    condition     = aws_savingsplans_savings_plan.this.savings_plan_offering_id == var.offering.id && length(data.aws_savingsplans_offerings.this) == 0
    error_message = "An explicit ID must bypass discovery and be used unchanged."
  }
}

run "explicit_id_ignores_hints" {
  command = plan
  variables {
    offering = {
      id       = "1cf796fe-9b14-45d4-b35f-fc9448e913b1"
      plan     = "Compute"
      type     = "ALL_UPFRONT"
      duration = 94608000
    }
  }
  assert {
    condition     = aws_savingsplans_savings_plan.this.savings_plan_offering_id == var.offering.id && length(data.aws_savingsplans_offerings.this) == 0
    error_message = "Descriptive hints must not override the explicit ID or trigger discovery."
  }
}

run "discover_offering" {
  command = plan
  variables {
    offering = {
      plan     = "Database"
      type     = "NO_UPFRONT"
      duration = 31536000
    }
  }
  assert {
    condition     = aws_savingsplans_savings_plan.this.savings_plan_offering_id == "2cd228b1-cae4-4c6b-bad6-d3a26e4dff7c" && length(data.aws_savingsplans_offerings.this) == 1
    error_message = "Without an explicit ID, use the offering returned by discovery."
  }
}
