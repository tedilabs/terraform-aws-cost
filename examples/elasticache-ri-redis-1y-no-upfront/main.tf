provider "aws" {
  region = "us-east-1"
}


###################################################
# ElastiCache RI (Reserved Instance)
###################################################

module "reserved_instance" {
  source = "../../modules/elasticache-reserved-instance"
  # source  = "tedilabs/cost/aws//modules/elasticache-reserved-instance"
  # version = "~> 0.2.0"

  name           = "elasticache-ri-example-redis-1y-no-upfront"
  instance_count = 1

  offering = {
    type          = "NO_UPFRONT"
    duration      = 1
    product       = "redis"
    instance_type = "cache.t4g.small"
  }

  tags = {
    "project" = "terraform-aws-cost-examples"
  }
}
