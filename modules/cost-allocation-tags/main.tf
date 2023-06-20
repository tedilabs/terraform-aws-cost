locals {
  metadata = {
    package = "terraform-aws-cost"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = var.name
  }
}


###################################################
# Cost Allocation Tags
###################################################

resource "aws_ce_cost_allocation_tag" "this" {
  for_each = toset(var.allocation_tags)

  tag_key = each.value
  status  = "Active"
}
