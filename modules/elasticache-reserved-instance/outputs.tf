output "region" {
  description = "The AWS region this module resources resides in."
  value       = aws_elasticache_reserved_cache_node.this.region
}

output "id" {
  description = "The unique identifier for the reservation."
  value       = aws_elasticache_reserved_cache_node.this.id
}

output "arn" {
  description = "The ARN for the reserved cache node."
  value       = aws_elasticache_reserved_cache_node.this.arn
}

output "name" {
  description = "The customer-specified identifier to track this reservation."
  value       = aws_elasticache_reserved_cache_node.this.id
}

output "instance_count" {
  description = "The number of reserved cache nodes."
  value       = aws_elasticache_reserved_cache_node.this.cache_node_count
}

output "offering" {
  description = <<EOF
  The offering information for the ElastiCache reserved cache node.
    `id` - The unique identifier for the reservation offering.
    `type` - The offering type of this reserved cache node.
    `duration` - The duration of the reservation as an RFC3339 duration.
    `product` - The engine type for the reserved cache node.
    `instance_type` - The cache node type for the reserved cache node, for example `cache.t4g.small`.
    `fixed_price` - The fixed price charged for this reserved cache node.
    `usage_price` - The hourly price charged for this offering.
    `recurring_price` - The recurring price charged to run this reserved cache node.
  EOF
  value = {
    id = data.aws_elasticache_reserved_cache_node_offering.this.offering_id
    type = {
      for k, v in local.offering_types :
      v => k
    }[aws_elasticache_reserved_cache_node.this.offering_type]
    duration = {
      for k, v in local.durations :
      v => k
    }[aws_elasticache_reserved_cache_node.this.duration]
    product       = aws_elasticache_reserved_cache_node.this.product_description
    instance_type = aws_elasticache_reserved_cache_node.this.cache_node_type

    fixed_price     = aws_elasticache_reserved_cache_node.this.fixed_price
    usage_price     = aws_elasticache_reserved_cache_node.this.usage_price
    recurring_price = aws_elasticache_reserved_cache_node.this.recurring_charges
  }
}

output "state" {
  description = "The state of the reserved cache node."
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
