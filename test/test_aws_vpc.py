import os
import json
import boto3
import pytest
from boto_mod import mod_test_vpc

# Set variables.


@pytest.fixture
def testdata():
    dir_path = os.path.dirname(os.path.realpath(__file__))
    path = dir_path + '/TERRAFORM_OUTPUT.json'
    data = {
        'region': 'us-east-1',
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


def test_vpc_present(record_xml_attribute, testdata, readterraout):
    record_xml_attribute("classname", "AWS Virtual Private Cloud Test")
    record_xml_attribute("name", "aws-vpc-001 - The VPC is setup"
                         + " in the specified region.")
# Define test vpc and define ec2 resource
    testvpn = readterraout['vpc_id']
    ec2 = boto3.resource('ec2', region_name="{}".format(testdata['region']))
# Select all vpcs in account
    filters = [{'Name': 'tag:Name', 'Values': ['*']}]
    vpcs = list(ec2.vpcs.filter(Filters=filters))
    vpc_ids = [item.vpc_id for item in vpcs]
# Check that test vpc is in the account
    assert vpc_ids.count(testvpn) > 0, "VPN is not present."


def test_private_subnets(record_xml_attribute, testdata, readterraout):
    record_xml_attribute("classname", "AWS Virtual Private Cloud Test")
    record_xml_attribute("name", "aws-vpc-002 - The Private subnet is setup"
                         + " and it does not have Internet gateway.")
# Define subnet and load vpc_mod
    privatesubnets = readterraout['private_subnets']
    vpc_mod = mod_test_vpc(testdata['region'], readterraout['vpc_id'])
# Check 1: Check that subnets exists
    check1 = vpc_mod.subnet_in_vpc(privatesubnets)
# Check 2: Check that subnets have not internet gateway
    check2 = not(vpc_mod.isPublic(privatesubnets))
# Assert if Check1 and Check2 are true
    assert (check1 * check2), "Private subnet is wrongly setup."


def test_public_subnets(record_xml_attribute, testdata, readterraout):
    record_xml_attribute("classname", "AWS Virtual Private Cloud Test")
    record_xml_attribute("name", "aws-vpc-003 - The Public subnet is setup"
                         + " and it has Internet gateway.")
# Define subnet and load vpc_mod
    publicsubnets = readterraout['public_subnets']
    vpc_mod = mod_test_vpc(testdata['region'], readterraout['vpc_id'])
# Check 1: Check that subnets exists
    check1 = vpc_mod.subnet_in_vpc(publicsubnets)
# Check 2: Check that subnets have internet gateway
    check2 = vpc_mod.isPublic(publicsubnets)
# Assert if Check1 and Check2 are true
    assert (check1 * check2), "Public subnet is wrongly setup."


def test_ip_blocks(record_xml_attribute, testdata, readterraout):
    record_xml_attribute("classname", "AWS Virtual Private Cloud Test")
    record_xml_attribute("name", "aws-vpc-004 - Private and Public Subnets"
                         + " have a dedicated ip block associated.")
    subnet_test = []
    CidrBlock = True
    subnet_test = readterraout['public_subnets'] + \
        readterraout['private_subnets']
    ec2_client = boto3.client(
        'ec2', region_name="{}".format(testdata['region']))
    sn_test = ec2_client.describe_subnets(SubnetIds=subnet_test)
    for sn in sn_test['Subnets']:
        if len(sn['CidrBlock']) == 0:
            CidrBlock = False
    assert CidrBlock, "One or more subnets do not have CidrBlock assigned."
