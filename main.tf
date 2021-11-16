# EC2 resource

## Execute this resource if "ec2_create" var is set to yes.

resource "aws_instance" "instance_ec2" {
  count         = contains(var.ec2_create, "yes") == true ? 1 : 0
  ami           = var.instance_ami
  instance_type = var.instance_type

  tags = {
    System = "Linux AMI"
    Name = "Test Instance"
  }
}
