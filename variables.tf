# EC2 vars

variable "ec2_create" {
  description = "Conditional Var"
  type = list
  default = []
}

variable "ec2_type" {
  description = "Type of instances"
  type = string
  default = "t2.micro"
}

variable "ec2_region" {
  description = "Region EC2 located"
  type = string
  default = "eu-central-1"
}

variable "ec2_tag_name" {
  description = "Tag Name"
  type = string
  default = "roche-test"
}

variable "ec2_tag_env" {
  description = "Tag Environment"
  type = string
  default = "dev-test"
}

variable "ec2_ami" {
  description = "Ubuntu Server 20.04 LTS (HVM), SSD Volume Type"
  type = string
  default = "ami-0a49b025fffbbdac6" # eu-central-1
}

variable "user_data" {
  description = "User Data"
  default = null
}

variable "ec2_instance_port" {
  description = "Ingress Port"
  type = number
  default = 22
}

variable "placement_group" {
  description = "Placement Group"
  default = null
}

variable "private_ip" {
  description = "private IP"
  default = null
}