output "region" {
  description = "The AWS region this module resources resides in."
  value       = aws_elasticache_reserved_cache_node.this.region
}

output "id" {
  description = "The unique identifier for the reservation."
  value       = aws_elasticache_reserved_cache_node.this.id
}

output "arn" {
  description = "The ARN for the reserved DB instance."
  value       = aws_elasticache_reserved_cache_node.this.arn
}

output "lease_id" {
  description = "The unique identifier for the lease associated with the reserved DB instance."
  value       = aws_elasticache_reserved_cache_node.this.lease_id
}
output "name" {
  description = "The customer-specified identifier to track this reservation."
  value       = aws_elasticache_reserved_cache_node.this.reservation_id
}

output "instance_count" {
  description = "The number of reserved instances."
  value       = aws_elasticache_reserved_cache_node.this.instance_count
}

output "offering" {
  description = <<EOF
  The offering information for the RDS reserved instance.
    `id` - The unique identifier for the reservation offering.
    `type` - The offering type of this reserved DB instance.
    `duration` - The duration of the reservation in seconds.
    `product` - The product description of the reserved DB instance.
    `instance_type` - The DB instance type(instance class) for the reserved DB instance, for example `db.m5.large`.
    `multi_az` - Whether the reservation is for Multi-AZ deployments.
    `currency_code` - The currency code for the reserved DB instance.
    `fixed_price` - The fixed price charged for this reserved DB instance.
    `usage_price` - The hourly price charged for this offering.
    `recurring_price` - The recurring price charged to run this reserved DB instance.
  EOF
  value = {
    id = data.aws_elasticache_reserved_cache_node_offering.this.id
    type = {
      for k, v in local.offering_types :
      v => k
    }[data.aws_elasticache_reserved_cache_node_offering.this.offering_type]
    duration      = data.aws_elasticache_reserved_cache_node_offering.this.duration
    product       = data.aws_elasticache_reserved_cache_node_offering.this.product_description
    instance_type = data.aws_elasticache_reserved_cache_node_offering.this.db_instance_class
    multi_az      = data.aws_elasticache_reserved_cache_node_offering.this.multi_az

    currency_code   = data.aws_elasticache_reserved_cache_node_offering.this.currency_code
    fixed_price     = data.aws_elasticache_reserved_cache_node_offering.this.fixed_price
    usage_price     = aws_elasticache_reserved_cache_node.this.usage_price
    recurring_price = aws_elasticache_reserved_cache_node.this.recurring_charges
  }
}

output "state" {
  description = "The state of the reserved DB instance."
  value       = aws_elasticache_reserved_cache_node.this.state
}

output "started_at" {
  description = "The time the reservation started."
  value       = aws_elasticache_reserved_cache_node.this.start_time
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
