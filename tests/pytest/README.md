# terraform-aws-ec2-module Unit Tests
---

These test are an example of a terraform module.
Tests check that EC2 instance exists and is running.

## Changelog
[View Changelog](CHANGELOG.md)

## Dependencies

[Python Unit Test dependencies](python-dependencies.txt)

## Test Script

- `ec2tests.py` : Check the information of EC2.

## Corresponding Requirements

- [aws-ec2-001.setup-a-ec2-instance.md](../../requirements/aws-ec2-001.setup-a-ec2-instance.md)
- [aws-ec2-002.setup-instance-is-in-running-state.md](../../requirements/aws-ec2-002.setup-instance-is-in-running-state.md)
- [aws-ec2-003.setup-with-specified-ami.md](../../requirements/aws-ec2-003.setup-with-specified-ami.md)

## Inputs

A script is running in jenkins pipeline to auto convert the terraform output json to the unittest input file format, taking the output name and value as the key: value pair. Therefore the inputs here are all the defined outputs from output.tf. Some additional variables like `TERRA_EXAMPLE_AK` and `TERRA_EXAMPLE_SK` are from ROCHE Conjur.

The script is as followings:

```
terraform output --json > ./tests/terraform_output.json
```

## Run the Test Cases

Run test cases through scripts in the Jenkins pipeline.

The script is as followings:

```sh
python3 -m pytest -v -s --color=yes -o junit_family=xunit2 --junitxml=./reports/junits_out.xml ../pytest/ec2tests.py
```
