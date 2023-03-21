variable "name" {
  description = "(Required) The customer-specified identifier to track this reservation."
  type        = string
  nullable    = false
}

variable "instance_count" {
  description = "(Optional) The number of instances to reserve. Defaults to `1`."
  type        = number
  default     = 1
  nullable    = false

  validation {
    condition = alltrue([
      var.instance_count >= 1
    ])
    error_message = "`instance_count` should be greater than `0`."
  }
}

variable "offering" {
  description = <<EOF
  (Required) The configuration for offering of the reservation. `offering` as defined below.
    (Required) `type` - The offering type of this reserved DB instance.
    (Required) `duration` - The duration of the reservation in years or seconds. Valid values are `1`, `3`, `31536000`, `94608000`.
    (Required) `product` - The product description of the reserved DB instance.
    (Required) `instance_class` - The DB instance type(instance class) for the reserved DB instance, for example `db.m5.large`. Not all DB instance classes are available in all AWS Regions, or for all database engines.
    (Required) `multi_az` - Whether the reservation is for Multi-AZ deployments.
  EOF
  type = object({
    type           = string
    duration       = number
    product        = string
    instance_class = string
    multi_az       = bool
  })
  nullable = false

  validation {
    condition     = contains(["NO_UPFRONT", "PARTIAL_UPFRONT", "ALL_UPFRONT"], var.offering.type)
    error_message = "Valid values for `offering.type` are `NO_UPFRONT`, `PARTIAL_UPFRONT`, `ALL_UPFRONT`."
  }

  validation {
    condition     = contains([1, 3, 31536000, 94608000], var.offering.duration)
    error_message = "Valid values for `offering.duration` are `1`, `3`, `31536000`, `94608000`."
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

variable "resource_group_enabled" {
  description = "(Optional) Whether to create Resource Group to find and group AWS resources which are created by this module."
  type        = bool
  default     = true
  nullable    = false
}

variable "resource_group_name" {
  description = "(Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`."
  type        = string
  default     = ""
  nullable    = false
}

variable "resource_group_description" {
  description = "(Optional) The description of Resource Group."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}
