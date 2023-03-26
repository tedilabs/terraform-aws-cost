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

  name           = "rds-ri-example-aurora-mysql-1y-no-upfront"
  instance_count = 1

  offering = {
    type           = "NO_UPFRONT"
    duration       = 1
    product        = "aurora-mysql"
    instance_class = "db.r6g.large"
    multi_az       = false
  }

  tags = {
    "project" = "terraform-aws-cost-examples"
  }
}
