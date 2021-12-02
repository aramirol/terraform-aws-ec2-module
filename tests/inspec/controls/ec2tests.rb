# Input variables
content = inspec.profile.file("terraform_output.json")
params  = JSON.parse(content)

# Get json values
instanceName = params["ec2_all"]["value"][0]["ec2_id"][0]

# Local variables
instanceRegion = "eu-central-1"

# Controls

control "EC2InstanceExists" do
  impact 1.0
  title "EC2 Instance Exists Test"
  desc "Checking if the AWS EC2 Instance has been successfully created"
  
  describe aws_ec2_instance(instance_id: instanceName, aws_region: instanceRegion) do
    it { should exist }
  end
end

control "EC2InstanceRunning" do
  impact 1.0
  title "EC2 Instance is Running"
  desc "Checking if the AWS EC2 Instance is in Running State"

  describe aws_ec2_instance(instance_id: instanceName, aws_region: instanceRegion) do
    it { should be_running }
  end
end

control "EC2CorrectAMI" do
  impact 1.0
  title "EC2 Instance AMI Test"
  desc "Checking if the AWS EC2 Instance has the correct AMI"

  describe aws_ec2_instance(instance_id: instanceName, aws_region: instanceRegion) do
    its('image_id') { should eq 'ami-0a49b025fffbbdac6' }
  end
end
