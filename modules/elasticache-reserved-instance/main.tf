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
  durations = {
    1 = "P1Y"
    3 = "P3Y"
  }
}


###################################################
# Reserved Instance for ElastiCache
###################################################

data "aws_elasticache_reserved_cache_node_offering" "this" {
  region = var.region

  offering_type       = local.offering_types[var.offering.type]
  duration            = local.durations[var.offering.duration]
  product_description = var.offering.product
  cache_node_type     = var.offering.instance_type
}

resource "aws_elasticache_reserved_cache_node" "this" {
  region = var.region

  id                               = var.name
  reserved_cache_nodes_offering_id = data.aws_elasticache_reserved_cache_node_offering.this.offering_id
  cache_node_count                 = var.instance_count

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}
