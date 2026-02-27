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
# Reserved Instance for ElastiCache
###################################################

data "aws_elasticache_reserved_cache_node_offering" "this" {
  region = var.region

  db_instance_class   = var.offering.instance_class
  duration            = var.offering.duration
  multi_az            = var.offering.multi_az
  offering_type       = local.offering_types[var.offering.type]
  product_description = var.offering.product
}

resource "aws_elasticache_reserved_cache_node" "this" {
  region = var.region

  reservation_id = var.name
  offering_id    = data.aws_elasticache_reserved_cache_node_offering.this.offering_id
  instance_count = var.instance_count

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}
