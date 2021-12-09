import os
import json
import boto3
import pytest


# Test if there are more than 0 instances
def test_ec2_instance_created():
    # Call EC2 to list current instances
	ec2 = boto3.client('ec2', region_name='eu-central-1')
	response = ec2.describe_instance_status()
	
	# Get a list of all instances IDs from the response
	instances = [instance['InstanceId'] for instance in response['InstanceStatuses']]

	assert len(instances) >= 1

# Print number of instances
client = boto3.client('ec2')
response = client.describe_instance_status()
print(len(response['InstanceStatuses']))


# Print the name of the bucket
ec2 = boto3.client('ec2', region_name='eu-central-1')
response = ec2.describe_instance_status()
print('Existing Instances:')
for instance in response['InstanceStatuses']:
    if instance["InstanceId"] == "i-05b670a646c40399c":
        print(f'  {instance["InstanceId"]}')


# Test if I can list all buckets
def test_ec2_instances_list():
    # Call EC2 to list current instances
	ec2 = boto3.client('ec2', region_name='eu-central-1')
	response = ec2.describe_instance_status()

	# Get a list of all bucket names from the response
	assert [instance['InstanceId'] for instance in response['InstanceStatuses']]
