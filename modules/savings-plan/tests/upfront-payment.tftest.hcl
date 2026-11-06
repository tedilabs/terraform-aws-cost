mock_provider "aws" {}
mock_provider "telemetry" {}

variables {
  name       = "upfront-test"
  commitment = 1
  offering = {
    id = "11111111-1111-1111-1111-111111111111"
  }
  telemetry = {
    enabled = false
  }
  resource_group = {
    enabled = false
  }
}

run "omitted_amount" {
  command = plan
  assert {
    condition     = var.upfront_payment_amount == null
    error_message = "Omitted amounts must remain null so AWS can populate the computed value."
  }
}

run "explicit_null" {
  command = plan
  variables {
    upfront_payment_amount = null
  }
  assert {
    condition     = var.upfront_payment_amount == null
    error_message = "Explicit null must not become zero."
  }
}

run "explicit_amount" {
  command = plan
  variables {
    upfront_payment_amount = 8760
  }
  assert {
    condition     = aws_savingsplans_savings_plan.this.upfront_payment_amount == "8760.00000000"
    error_message = "Explicit amounts must retain their existing eight-decimal representation."
  }
}

run "explicit_zero" {
  command = plan
  variables {
    upfront_payment_amount = 0
  }
  assert {
    condition     = aws_savingsplans_savings_plan.this.upfront_payment_amount == "0.00000000"
    error_message = "Explicit zero must not silently become null."
  }
}

run "negative_amount" {
  command = plan
  variables {
    upfront_payment_amount = -1
  }
  expect_failures = [var.upfront_payment_amount]
}
