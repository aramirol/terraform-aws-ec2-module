# EC2 resource

resource "aws_instance" "instance_test" {
  count         = contains(var.ec2_create, "instance") != true ? 0 : 1
  ami           = var.instance_ami
  instance_type = var.instance_type

  tags = {
    System = "Linux AMI"
    Name = "Instance test"
  }
}
