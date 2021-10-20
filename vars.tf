# EC2 vars

variable "instance_count" {
  description = "Number of instances"
  default = "1"
}

variable "instance_type" {
  description = "Type of instances"
  default = "t2.micro"
}

variable "instance_ami" {
  description = "Amazon Linux instance"
  default = "ami-058e6df85cfc7760b" # eu-central-1
}