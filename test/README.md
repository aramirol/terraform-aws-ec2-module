# terraform-module-aws-vpc-example Unit Tests
---

These test are an example of a terraform module.
Tests check whether a vpc, a public and a private subnet exists.

## Changelog
[View Changelog](CHANGELOG.md)

## Dependencies

[Python Unit Test dependencies](python-dependencies.txt)

## Test Script

- `test_aws_vpc.py` : Check the information of VPC.

## Corresponding Requirements

- [aws-vpc-001.establish-dedicated-network-connection.md](../requirements/aws-vpc-001.establish-dedicated-network-connection.md)
- [aws-vpc-002.setup-a-private-subnet](../requirements/aws-vpc-002.setup-a-private-subnet.md)
- [iaws-vpc-003.setup-a-public-subnet](../requirements/aws-vpc-003.setup-a-public-subnet.md)
- [aws-vpc-004.dedicated-ip-range-for-each-subnet](../requirements/aws-vpc-004.dedicated-ip-range-for-each-subnet.md)

## Inputs

A script is running in jenkins pipeline to auto convert the terraform output json to the unittest input file format, taking the output name and value as the key: value pair. Therefore the inputs here are all the defined outputs from output.tf. Some additional variables like `TERRA_EXAMPLE_AK` and `TERRA_EXAMPLE_SK` are from ROCHE Conjur.

The script is as followings:

```
terraform output --json > ./tests/TERRAFORM_OUTPUT.json
```

## Run the Test Cases

Run test cases through scripts in the Jenkins pipeline.

The script is as followings:

```sh
python3 -m py.test -v -s --color=yes test_aws_vpc.py -o junit-reports
```
