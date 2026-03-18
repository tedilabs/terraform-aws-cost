variable "name" {
  description = "(Required) The customer-specified identifier to track this savings plan. Only used for `Name` resource tag."
  type        = string
  nullable    = false
}

variable "commitment" {
  description = "(Required) The hourly commitment, in USD. This is the amount you commit to pay per hour, regardless of actual usage."
  type        = number
  nullable    = false

  validation {
    condition     = var.commitment > 0
    error_message = "Valid value for `commitment` is a number greater than 0."
  }
}

variable "upfront_payment_amount" {
  description = "(Optional) The up-front payment amount. This is a whole number between 50 and 99 percent of the total value of the Savings Plan. This parameter is only supported if the payment option is `PARTIAL_UPFRONT`."
  type        = number
  default     = 0
  nullable    = false

  validation {
    condition = alltrue([
      var.upfront_payment_amount >= 0,
      var.upfront_payment_amount <= (var.commitment * 94608000 / (60 * 60)),
    ])
    error_message = "Valid value for `upfront_payment_amount` is a number between 0 and the total value of the Savings Plan."
  }
}

variable "purchase_at" {
  description = "(Optional) The time at which to purchase the Savings Plan, in UTC format (YYYY-MM-DDTHH:MM:SSZ). If not specified, the plan is purchased immediately. Plans with a future purchase time are placed in queued state and can be deleted before they become active."
  type        = string
  default     = null
  nullable    = true

  validation {
    condition     = var.purchase_at == null || can(regex("^\\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12]\\d|3[01])T([01]\\d|2[0-3]):[0-5]\\d:[0-5]\\dZ$", var.purchase_at))
    error_message = "Valid value for `purchase_at` is a valid timestamp string."
  }
}

variable "offering" {
  description = <<EOF
  (Required) The configuration for offering of the savings plan. `offering` as defined below.
    (Optional) `id` - The unique identifier for the savings plan offering. If specified, the other parameters in `offering` will be ignored and the offering with this ID will be used for purchasing the savings plan.
    (Optional) `plan` - A plan type of the savings plan. Valid values are `Compute`, `EC2Instance`, `SageMaker`, `Database`.
    (Optional) `type` - The offering type of this savings plan. Valid values are `NO_UPFRONT`, `PARTIAL_UPFRONT`, `ALL_UPFRONT`.
    (Optional) `duration` - The duration of the reservation in seconds. Valid values are `31536000`, `94608000`.
      (Optional) `region` - The region of the savings plan. Only required for `EC2Instance` savings plans.
  EOF
  type = object({
    id       = optional(string)
    plan     = optional(string)
    type     = optional(string)
    duration = optional(number)
    region   = optional(string)
  })
  nullable = false

  validation {
    condition     = var.offering.plan == null || contains(["Compute", "EC2Instance", "SageMaker", "Database"], var.offering.plan)
    error_message = "Valid values for `offering.plan` are `Compute`, `EC2Instance`, `SageMaker`, `Database`."
  }
  validation {
    condition     = var.offering.type == null || contains(["NO_UPFRONT", "PARTIAL_UPFRONT", "ALL_UPFRONT"], var.offering.type)
    error_message = "Valid values for `offering.type` are `NO_UPFRONT`, `PARTIAL_UPFRONT`, `ALL_UPFRONT`."
  }
  validation {
    condition     = var.offering.duration == null || contains([31536000, 94608000], var.offering.duration)
    error_message = "Valid values for `offering.duration` are `31536000`, `94608000`."
  }
}

variable "tags" {
  description = "(Optional) A map of tags to add to all resources."
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "module_tags_enabled" {
  description = "(Optional) Whether to create AWS Resource Tags for the module informations."
  type        = bool
  default     = true
  nullable    = false
}


###################################################
# Resource Group
###################################################

variable "resource_group" {
  description = <<EOF
  (Optional) A configurations of Resource Group for this module. `resource_group` as defined below.
    (Optional) `enabled` - Whether to create Resource Group to find and group AWS resources which are created by this module. Defaults to `true`.
    (Optional) `name` - The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. If not provided, a name will be generated using the module name and instance name.
    (Optional) `description` - The description of Resource Group. Defaults to `Managed by Terraform.`.
  EOF
  type = object({
    enabled     = optional(bool, true)
    name        = optional(string, "")
    description = optional(string, "Managed by Terraform.")
  })
  default  = {}
  nullable = false
}
