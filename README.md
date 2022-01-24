# Terraform EC2 Module example

[![Build Status (Master)](https://rbalvjenkinm.bas.roche.com/job/IAC_ENG/job/IAC_ENG/job/terraform-module-aws-ec2-example/job/master/badge/icon)](https://rbalvjenkinm.bas.roche.com/job/IAC_ENG/job/IAC_ENG/job/terraform-module-aws-ec2-example/job/master/)

## Introduction

![](https://img.shields.io/badge/terraform-v1.0.9-blueviolet?logo=terraform) ![](https://img.shields.io/badge/aws-3.60.0-yellow?logo=amazonaws)

This code is an example of a terraform module. Create an EC2 instance with some additional settings like security-group.

This code is for a:\
[X] COMPONENT [ ] ENABLER

## Framework or Coding Technology

-----BEGIN TECH-----\
TECH-Main: terraform\
TECH-Testing: python-unittest, python-unittest-xml-reporting\
TECH-Auxiliary: N/A\
TECH-CICD: Jenkinsfile\
-----END TECH-----

# Execution methods

## From command line

```sh
$ git clone -b 1.0.0 –-depth 1 https://bitbk.roche.com/scm/iac_eng/terraform-module-aws-ec2-example.git
$ cd terraform-module-aws-ec2-example
$ terraform init
$ terraform validate
$ terraform plan
$ terraform apply -auto-approve -parallelism=2
```

## From a terraform implementation file

```hcl
# Testing EC2 Terraform Module

# Apply region configuration
provider "aws" {
  region  = "eu-central-1"
}

# Calling EC2 module
module "ec2" {
  source  = "git::https://bitbk.roche.com/scm/iac_eng/terraform-module-aws-ec2-example.git?ref=1.0.0"
}

output "ec2_all" {
  description = "Show all"
  value       = module.ec2.*
}
```
## Inputs

| Name | Type | Required | Description |
| ---- | ---- | -------- | ----------- |
| **ec2_create** | `string` | no | Conditional var to create instance |
| **ec2_type** | `string` | yes | Type of the instance. `t2.micro` by default |
| **ec2_region** | `string` | yes | Region where instance will located. `eu-central-1` by defaut |
| **ec2_tag_name** | `string` | yes | A tag with a name to the instance |
| **ec2_tag_env** | `string` | yes | A tag with the environment where instance will be located |
| **ec2_ami** | `string` | yes | The OS that the instance will use. |
| **user_data** | `string` | no | To enter text in a file |
| **ec2_instance_port** | `number` | no | Instance SSH port. 22 by default |
| **placement_group** | `string` | no | The placement group to deploy the EC2 instance |
| **private_ip** | `string` | no | The private IP to the instance |
| **vpc_id** | `string` | no | The VPN ID that the instance will use |

## Outputs

| Name | Type | Description |
| ---- | ---- | ----------- |
| **ec2_ip** | `string` | EC2 instance IP |
| **ec2_type** | `string` | EC2 instance type |
| **ec2_id** | `string` | EC2 instance ID |
| **ec2_name** | `string` | EC2 instance tag name |
| **ec2_ami** | `string` | EC2 instance AMI |

## Dependencies

| Software/Framework/Code repository                           | Version/Description                                          |
| :------------------ | :--------------------|
| terraform   | >= 0.12.31   |
| [terraform-provider-aws](https://github.com/hashicorp/terraform-provider-aws) | >= 3.60"  |
| [python-dependencies.txt](./tests/pytest/python-dependencies.txt) | See python dependencies file for software and version details |

## Tested Versions

|         **Version**         | **Release Date** | **Build number** |
| :-------------------------: | :--------------: | :--------------: |
|   terraform-provider-aws    |    03/12/2021    |     v3.60.0      |

## Supporting Documents, Handbooks, QPs and TOPs

| **Requirements** | **Link** |
| :--------------: | :------: |
|       N/A        |   N/A    |

| **Design Documents (HLD/LLD/etc.)** |                           **Link**                           |
| :---------------------------------: | :----------------------------------------------------------: |
|        Solution Architecture        |                             N/A                              |

| **TOPs/QPs/WIs** | **Link** |
| :--------------: | :------: |
|       N/A        |   N/A    |

## Manual Tests

N/A

## Deviations and open defects

N/A

## Author Information

IaC Engineering Team (https://iac-portal.roche.com)

## License

Copyright (c) 2021 F. Hoffmann-La Roche Ltd. All rights reserved.\
Roche Global Infrastructure & Solutions.
