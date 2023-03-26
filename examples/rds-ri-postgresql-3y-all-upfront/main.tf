provider "aws" {
  region = "us-east-1"
}


###################################################
# RDS RI (Reserved Instance)
###################################################

module "reserved_instance" {
  source = "../../modules/rds-reserved-instance"
  # source  = "tedilabs/cost/aws//modules/rds-reserved-instance"
  # version = "~> 0.2.0"

  name           = "rds-ri-example-postgresql-3y-all-upfront"
  instance_count = 1

  offering = {
    type           = "ALL_UPFRONT"
    duration       = 3
    product        = "postgresql"
    instance_class = "db.r6g.large"
    multi_az       = true
  }

  tags = {
    "project" = "terraform-aws-cost-examples"
  }
}
