import os
import json
import boto3
import pytest

##################################################################

# Read json file from terraform output
@pytest.fixture
def testdata():
    dir_path = os.path.dirname(os.path.realpath(__file__))
    path = dir_path + '/terraform_output.json'
    data = {
        'region': 'eu-central-1', # Adding custom region to json parameters
        'path': (path)
    }
    return data

@pytest.fixture
def readterraout(testdata):
    data = {}
    with open(testdata['path'], 'r') as f:
        output_json = json.load(f)
    for output_key, output_value in output_json.items():
        data[output_key] = output_value['value']
    data = data['ec2_all'][0] # Filter values from output key
    return data # Return a list of values

##################################################################

# AWS-EC2-001
# Test if the new instance was created
def test_ec2_instance_created(record_xml_attribute, testdata, readterraout):
    record_xml_attribute("classname", "AWS EC2 Instance Test")
    record_xml_attribute("name", "aws-ec2-001 - AWS EC2 instance"
                         + " has been successfully created.")
    # Define the new EC2 instance
    instanceName = readterraout['ec2_id'][0]
    # Select de EC2 created
    ec2 = boto3.client('ec2', region_name="{}".format(testdata['region']))
    instance_id = ec2.describe_instance_status(InstanceIds=[instanceName])
    # Assert if the instance was created
    assert instance_id['InstanceStatuses'][0]['InstanceId'] == instanceName #print(instance_id)

# AWS-EC2-002
# Test if the new instance is running
def test_ec2_instance_running(record_xml_attribute, testdata, readterraout):
    record_xml_attribute("classname", "AWS EC2 Instance Test")
    record_xml_attribute("name", "aws-ec2-002 - AWS EC2 instance"
                         + " is in running state.")
    # Define the new EC2 instance
    instanceName = readterraout['ec2_id'][0]
    # Select de EC2 created
    ec2 = boto3.client('ec2', region_name="{}".format(testdata['region']))
    instance_status = ec2.describe_instance_status(InstanceIds=[instanceName])
    # Assert if the instance is running
    assert instance_status['InstanceStatuses'][0]['InstanceState']['Name'] == 'running' #print(instance_status)

# AWS-EC2-003
# Test if the new instance has the specified AMI
def test_ec2_instance_ami(record_xml_attribute, testdata, readterraout):
    record_xml_attribute("classname", "AWS EC2 Instance Test")
    record_xml_attribute("name", "aws-ec2-003 - AWS EC2 instance"
                         + " has the specified AMI.")
    # Define the new EC2 instance
    instanceName = readterraout['ec2_id'][0]
    instanceAMI = readterraout['ec2_ami'][0]
    # Select de EC2 created
    ec2 = boto3.client('ec2', region_name="{}".format(testdata['region']))
    instance_ami = ec2.describe_instances(InstanceIds=[instanceName])
    # Assert if the instance was deployed using the specified AMI
    assert instance_ami['Reservations'][0]['Instances'][0]['ImageId'] == instanceAMI #print(instance_ami)
