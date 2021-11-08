# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/guides/custom-service-endpoints#localstack

provider "aws" {
  access_key                  = "mock_access_key"
  region                      = "eu-central-1"
  s3_force_path_style         = true
  secret_key                  = "mock_secret_key"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    apigateway     = "http://192.168.1.196:31566" 
    cloudformation = "http://192.168.1.196:31566"
    cloudwatch     = "http://192.168.1.196:31566"
    dynamodb       = "http://192.168.1.196:31566"
    ec2            = "http://192.168.1.196:31566"
    es             = "http://192.168.1.196:31566"
    firehose       = "http://192.168.1.196:31566"
    iam            = "http://192.168.1.196:31566"
    kinesis        = "http://192.168.1.196:31566"
    lambda         = "http://192.168.1.196:31566"
    route53        = "http://192.168.1.196:31566"
    redshift       = "http://192.168.1.196:31566"
    s3             = "http://192.168.1.196:31566"
    secretsmanager = "http://192.168.1.196:31566"
    ses            = "http://192.168.1.196:31566"
    sns            = "http://192.168.1.196:31566"
    sqs            = "http://192.168.1.196:31566"
    ssm            = "http://192.168.1.196:31566"
    stepfunctions  = "http://192.168.1.196:31566"
    sts            = "http://192.168.1.196:31566"
  }
}

# EC2 module

module "ec2_basic" {
  source          = "../"

  ec2_create = ["instance_basic"]
}

module "ec2_pro" {
  source  = "../"

  ec2_create = ["instance_pro"]
}

# EC2 outputs

output "instances_ip_basic" {
  description = "Instance IP"
  value       = module.ec2_basic.instances_ip
}

output "instances_type_basic" {
  description = "Instance Type "
  value       = module.ec2_basic.instances_type
}

output "instances_id_basic" {
  description = "Instance ID "
  value       = module.ec2_basic.instances_id
}

output "instances_ip_pro" {
  description = "Instance IP"
  value       = module.ec2_pro.instances_ip
}

output "instances_type_pro" {
  description = "Instance Type "
  value       = module.ec2_pro.instances_type
}

output "instances_id_pro" {
  description = "Instance ID "
  value       = module.ec2_pro.instances_id
}