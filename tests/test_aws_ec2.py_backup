import os
import json
import boto3
import pytest
import pytest_localstack
from boto_mod import mod_test_ec2

# Set variables.


@pytest.fixture
def testdata():
    dir_path = os.path.dirname(os.path.realpath(__file__))
    path = dir_path + '/TERRAFORM_OUTPUT.json'
    data = {
        'region': 'eu-central-1',
        'path': (path)
    }
    return data

# Read json output from terraform.


@pytest.fixture
def readterraout(testdata):
    data = {}
    with open(testdata['path'], 'r') as f:
        output_json = json.load(f)
    for output_key, output_value in output_json.items():
        data[output_key] = output_value['value']
    data = data['test_output'][0]
    return data

# ======= Tests definitions =========


def test_ec2_present(record_xml_attribute, testdata, readterraout):
    record_xml_attribute("classname", "AWS Virtual Private Cloud Test")
    record_xml_attribute("name", "aws-vpc-001 - The VPC is setup"
                         + " in the specified region.")
# Define test ec2
    testec2 = readterraout['instances_id']
# Select all ec2 in account
    filters = [{'Name': 'tag:Name', 'Values': ['*']}]
    vpcs = list(ec2.vpcs.filter(Filters=filters))
    vpc_ids = [item.vpc_id for item in vpcs]
# Check that test vpc is in the account
    assert vpc_ids.count(testvpn) > 0, "VPN is not present."
