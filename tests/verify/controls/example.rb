# copyright: 2018, The Authors

title 'two tier setups'

####### load data from terraform output

content = inspec.profile.file("terraform.json")
params = JSON.parse(content)

INSTANCE_ID = params['instance_id']['value']

####### execute test in ec2 instance

describe aws_ec2_instance(INSTANCE_ID_BASIC) do
  it { should be_running }
  its('instance_type') { should eq 't2.micro' }
end
