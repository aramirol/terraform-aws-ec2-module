# Testing EC2 Terraform Module
##################################################

# Apply region configuration
##################################################
provider "aws" {
  region  = "eu-central-1"
}

# Calling EC2 module
##################################################
module "ec2" {
  source  = "../"
}

output "ec2_all" {
  description = "Show all"
  value       = module.ec2.*
}
