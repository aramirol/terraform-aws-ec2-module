# EC2 resource

## Execute this resource if "ec2_create" var is instance_basic.

resource "aws_instance" "instance_basic" {
  count         = contains(var.ec2_create, "instance_basic") != true ? 0 : 1
  ami           = var.instance_ami
  instance_type = var.instance_type_basic

  tags = {
    System = "Linux AMI"
    Name = "Instance Basic"
  }
}

## Execute this resource if "ec2_create" var is instance_pro.

resource "aws_instance" "instance_pro" {
  count         = contains(var.ec2_create, "instance_pro") != true ? 0 : 1
  ami           = var.instance_ami
  instance_type = var.instance_type_pro

  tags = {
    System = "Linux AMI"
    Name = "Instance Pro"
  }
}

