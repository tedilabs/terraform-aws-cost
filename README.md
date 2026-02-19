# terraform-aws-cost

![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/tedilabs/terraform-aws-cost?color=blue&sort=semver&style=flat-square)
![GitHub](https://img.shields.io/github/license/tedilabs/terraform-aws-cost?color=blue&style=flat-square)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white&style=flat-square)](https://github.com/pre-commit/pre-commit)

Terraform module which creates cost related resources on AWS.

- [cur-report](./modules/cur-report)
- [rds-reserved-instance](./modules/rds-reserved-instance)


## Target AWS Services

Terraform Modules from [this package](https://github.com/tedilabs/terraform-aws-cost) were written to manage the following AWS Services with Terraform.

- **AWS CUR (Cost and Usage Report)**
  - Report
- **AWS ElastiCache**
  - Reserved Instance - Comming Soon!
- **AWS RDS (Relational Database Service)**
  - Reserved Instance
- **AWS Savings Plan**
  - Comming Soon!


## Usage

### AWS CUR (Cost and Usage Report)

```tf
module "cur_report" {
  source  = "tedilabs/cost/aws//modules/cur-report"
  version = "~> 0.1.0"

  name        = "example-report"


  ## Delivery Options
  time_granularity     = "HOURLY"
  versioning_strategy  = "OVERWRITE_REPORT"
  data_refresh_enabled = true


  ## Delivery Destination
  delivery_s3_bucket = {
    name       = "hello-my-bucket"
    key_prefix = "test/"
    region     = "us-east-1"
  }


  ## Content
  compression_format         = "GZIP"
  additional_schema_elements = ["RESOURCES"]
  additional_artifacts       = ["REDSHIFT", "QUICKSIGHT"]
}
```


## Examples

### AWS CUR (Cost and Usage Report)

- [CUR Report](./examples/cur-report)

### AWS RDS (Relational Database Service)

- [RDS Reserved Instance: Aurora MySQL for 1 Year with no upfront](./examples/rds-ri-aurora-mysql-1y-no-upfront)
- [RDS Reserved Instance: PostgreSQL for 3 Year with all upfront](./examples/rds-ri-postgresql-3y-all-upfront)


## Self Promotion

Like this project? Follow the repository on [GitHub](https://github.com/tedilabs/terraform-aws-cost). And if you're feeling especially charitable, follow **[posquit0](https://github.com/posquit0)** on GitHub.


## License

Provided under the terms of the [Apache License](LICENSE).

Copyright © 2023-2026, [Byungjin Park](https://www.posquit0.com).