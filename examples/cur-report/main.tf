provider "aws" {
  region = "us-east-1"
}


###################################################
# CUR (Cost and Usage Report)
###################################################

module "cur_report" {
  source = "../../modules/cur-report"
  # source  = "tedilabs/cost/aws//modules/cur-report"
  # version = "~> 0.2.0"

  name = "cur-report-example"


  ## Delivery Options
  time_granularity     = "HOURLY"
  versioning_strategy  = "OVERWRITE_REPORT"
  data_refresh_enabled = true


  ## Delivery Destination
  delivery_s3_bucket = {
    name       = module.bucket.name
    key_prefix = "test/"
    region     = "us-east-1"
  }


  ## Content
  compression_format         = "GZIP"
  additional_schema_elements = ["RESOURCES"]
  additional_artifacts       = ["REDSHIFT", "QUICKSIGHT"]

  depends_on = [
    module.bucket.access_control,
  ]
}


###################################################
# S3 Bucket
###################################################

resource "random_string" "this" {
  length  = 32
  special = false
  numeric = false
  upper   = false
}

locals {
  bucket_name = "cur-report-example-${random_string.this.id}"
}

module "bucket" {
  source  = "tedilabs/data/aws//modules/s3-bucket"
  version = "~> 0.5.0"

  name          = local.bucket_name
  force_destroy = true

  policy = jsonencode(yamldecode(<<EOF
    Version: "2008-10-17"
    Statement:
    - Effect: "Allow"
      Principal:
        Service: "billingreports.amazonaws.com"
      Action:
      - "s3:GetBucketAcl"
      - "s3:GetBucketPolicy"
      Resource: "arn:aws:s3:::${local.bucket_name}"
    - Effect: "Allow"
      Principal:
        Service: "billingreports.amazonaws.com"
      Action:
      - "s3:PutObject"
      Resource: "arn:aws:s3:::${local.bucket_name}/*"
  EOF
  ))

  tags = {
    "project" = "terraform-aws-cost-examples"
  }
}
