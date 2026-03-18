output "id" {
  description = "The ID of the Savings Plan."
  value       = aws_savingsplans_savings_plan.this.savings_plan_id
}

output "arn" {
  description = "The ARN of the Savings Plan."
  value       = aws_savingsplans_savings_plan.this.savings_plan_arn
}

output "name" {
  description = "The customer-specified identifier to track this savings plan."
  value       = var.name
}

output "commitment" {
  description = "The hourly commitment, in USD. This is the amount you commit to pay per hour, regardless of actual usage."
  value       = aws_savingsplans_savings_plan.this.commitment
}

output "upfront_payment_amount" {
  description = "The up-front payment amount."
  value       = aws_savingsplans_savings_plan.this.upfront_payment_amount
}

output "recurring_payment_amount" {
  description = "The recurring payment amount."
  value       = aws_savingsplans_savings_plan.this.recurring_payment_amount
}

output "offering" {
  description = <<EOF
  The offering information for the Savings Plan.
    `id` - The unique identifier for the Savgins Plan.
    `plan` - The plan type of the Savings Plan.
    `type` - The offering type of this Savings Plan.
    `description` - The description of the Savings Plan.
    `duration` - The duration of the Savings Plan in seconds.
    `product_types` - The product types applicable to the Savings Plan.
    `currency_code` - The currency code of the Savings Plan.
    `ec2` - The EC2-specific attributes of the Savings Plan. Only present for `EC2Instance` Savings Plans. Contains the following attributes:
      `instance_family` - The instance family of the EC2Instance Savings Plan, for example `m5`.
  EOF
  value = {
    id   = aws_savingsplans_savings_plan.this.savings_plan_offering_id
    plan = aws_savingsplans_savings_plan.this.savings_plan_type
    type = {
      for k, v in local.offering_types :
      v => k
    }[aws_savingsplans_savings_plan.this.payment_option]
    description   = aws_savingsplans_savings_plan.this.description
    duration      = aws_savingsplans_savings_plan.this.term_duration_in_seconds
    product_types = aws_savingsplans_savings_plan.this.product_types
    currency_code = aws_savingsplans_savings_plan.this.currency
    ec2 = (aws_savingsplans_savings_plan.this.savings_plan_type == "EC2Instance"
      ? {
        instance_family = aws_savingsplans_savings_plan.this.ec2_instance_family
      }
      : null
    )
  }
}

output "state" {
  description = "The current state of the Savings Plan."
  value       = aws_savingsplans_savings_plan.this.state
}

output "purchase_at" {
  description = "The purchase time of the Savings Plan."
  value       = aws_savingsplans_savings_plan.this.purchase_time
}

output "returnable_until" {
  description = "The time until when a return for the Savings Plan can be requested. If the Savings Plan is not returnable, the field reflects the Savings Plans start time."
  value       = aws_savingsplans_savings_plan.this.returnable_until
}

output "start_at" {
  description = "The start time of the Savings Plan."
  value       = aws_savingsplans_savings_plan.this.start
}

output "end_at" {
  description = "The end time of the Savings Plan."
  value       = aws_savingsplans_savings_plan.this.end
}

output "resource_group" {
  description = "The resource group created to manage resources in this module."
  value = merge(
    {
      enabled = var.resource_group.enabled && var.module_tags_enabled
    },
    (var.resource_group.enabled && var.module_tags_enabled
      ? {
        arn  = module.resource_group[0].arn
        name = module.resource_group[0].name
      }
      : {}
    )
  )
}

# output "debug" {
#   value = {
#     for k, v in aws_savingsplans_savings_plan.this :
#     k => v
#     if !contains(["tags", "tags_all", "offering_id", "payment_option", "currency", "state", "start", "end", "savings_plan_id", "savings_plan_arn", "purchase_time", "region", "commitment", "upfront_payment_amount", "timeouts", "savings_plan_offering_id", "returnable_until", "recurring_payment_amount", "description", "savings_plan_type", "product_types", "term_duration_in_seconds", "ec2_instance_family"], k)
#   }
# }

# output "debug2" {
#   value = {
#     for k, v in data.aws_savingsplans_offerings.this :
#     k => v
#   }
# }
