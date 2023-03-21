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
}
```


## Examples

### AWS CUR (Cost and Usage Report)

- Comming soon


## Self Promotion

Like this project? Follow the repository on [GitHub](https://github.com/tedilabs/terraform-aws-cost). And if you're feeling especially charitable, follow **[posquit0](https://github.com/posquit0)** on GitHub.


## License

Provided under the terms of the [Apache License](LICENSE).

Copyright © 2023, [Byungjin Park](https://www.posquit0.com).
