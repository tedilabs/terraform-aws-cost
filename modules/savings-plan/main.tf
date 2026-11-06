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

locals {
  offering_types = {
    "NO_UPFRONT"      = "No Upfront"
    "PARTIAL_UPFRONT" = "Partial Upfront"
    "ALL_UPFRONT"     = "All Upfront"
  }
}


###################################################
# Savings Plan
###################################################

data "aws_savingsplans_offerings" "this" {
  count = var.offering.id != null ? 0 : 1

  offering_ids = (var.offering.id != null
    ? [var.offering.id]
    : null
  )

  plan_types = (var.offering.id != null
    ? null
    : (var.offering.plan != null
      ? [var.offering.plan]
      : null
    )
  )
  payment_options = (var.offering.id != null
    ? null
    : (var.offering.type != null
      ? [local.offering_types[var.offering.type]]
      : null
    )
  )
  durations = (var.offering.id != null
    ? null
    : (var.offering.duration != null
      ? [var.offering.duration]
      : null
    )
  )

  ## Region (EC2Instance Savings Plans only)
  dynamic "filter" {
    for_each = (var.offering.id == null && var.offering.plan == "EC2Instance") ? ["go"] : []

    content {
      name   = "region"
      values = [var.offering.region]
    }
  }

  lifecycle {
    postcondition {
      condition     = length(self.offerings) == 1
      error_message = "The specified `offering` does not uniquely identify a Savings Plan offering. Please check the `offering` configuration and make sure it can uniquely identify a Savings Plan offering."
    }
  }
}

locals {
  offering_data = (var.offering.id != null
    ? null
    : data.aws_savingsplans_offerings.this[0].offerings[0]
  )
  offering = (var.offering.id != null
    ? {
      id       = var.offering.id
      plan     = null
      type     = null
      duration = null
    }
    : {
      id   = local.offering_data.offering_id
      plan = local.offering_data.plan_type
      type = {
        for k, v in local.offering_types :
        v => k
      }[local.offering_data.payment_option]
      duration = local.offering_data.duration_seconds
    }
  )
}

resource "aws_savingsplans_savings_plan" "this" {
  savings_plan_offering_id = local.offering.id
  commitment               = format("%.8f", var.commitment)
  upfront_payment_amount = (var.upfront_payment_amount != null
    ? format("%.8f", var.upfront_payment_amount)
    : null
  )

  purchase_time = var.purchase_at

  lifecycle {
    precondition {
      condition = (var.upfront_payment_amount == null || local.offering.duration == null
        ? true
        : var.upfront_payment_amount <= (var.commitment * local.offering.duration / (60 * 60))
      )
      error_message = "The upfront payment amount must not exceed the commitment over the selected offering's actual duration."
    }
    precondition {
      condition = (local.offering.type == "PARTIAL_UPFRONT"
        ? (var.upfront_payment_amount != null
          ? alltrue([
            floor(var.upfront_payment_amount) == var.upfront_payment_amount,
            var.upfront_payment_amount >= (var.commitment * local.offering.duration / (60 * 60) * 0.50),
            var.upfront_payment_amount <= (var.commitment * local.offering.duration / (60 * 60) * 0.99),
          ])
          : false
        )
        : true
      )
      error_message = "Partial Upfront offerings require a whole-number upfront payment between 50 and 99 percent of the total commitment."
    }
    precondition {
      condition = (local.offering.type == "NO_UPFRONT"
        ? var.upfront_payment_amount == null
        : true
      )
      error_message = "No Upfront offerings require upfront_payment_amount to be omitted (null), including instead of zero."
    }
  }

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}
