#!/usr/bin/env ruby
# copyright: 2018, The Authors

title 'two tier setup'

# Input variables
content = inspec.profile.file("terraforn.json")
params  = JSON.parse(content)

# Get json values
instanceId   = params['instance_id']['value']
instanceName = params['instance_name']['value']

# Controls
control 'instance-control' do
  title 'LSOE EC2 instance checks'
  desc 'Check that AWS EC2 instance has been correctly deployed'

  describe aws_ec2_instance(instanceId) do
    it { should exist }
    it { should be_running }
    its('image_id') { should eq 'ami-058e6df85cfc7760b' }
    its('tags') { should include(key: 'Name', value: instanceName ) }
    it { should have_roles }
  end
end
