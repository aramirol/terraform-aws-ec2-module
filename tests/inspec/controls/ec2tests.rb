# Input variables
content = inspec.profile.file("terraform_output.json")
params  = JSON.parse(content)

# Get json values
instanceName = params["ec2_all"]["value"][0]["ec2_id"][0]

# Local variables
instanceRegion = "eu-central-1"

# Controls

control "aws-ec2-001" do
  impact 1.0
  title "Setup a EC2 instance"
  desc "Checking if the AWS EC2 Instance has been successfully created"
  
  describe aws_ec2_instance(instance_id: instanceName, aws_region: instanceRegion) do
    it { should exist }
  end
end

control "aws-ec2-002" do
  impact 1.0
  title "EC2 instance is in running state"
  desc "Checking if the AWS EC2 Instance is in Running State"

  describe aws_ec2_instance(instance_id: instanceName, aws_region: instanceRegion) do
    it { should be_running }
  end
end

control "aws-ec2-003" do
  impact 1.0
  title "Setup with specified AMI"
  desc "Checking if the AWS EC2 Instance has the correct AMI"

  describe aws_ec2_instance(instance_id: instanceName, aws_region: instanceRegion) do
    its('image_id') { should eq 'ami-0a49b025fffbbdac6' }
  end
end
