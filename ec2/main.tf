# EC2 resource

resource "aws_instance" "instance_test" {
  count         = var.instance_count
  ami           = var.instance_ami
  instance_type = var.instance_type

  tags = {
    System = "Linux AMI"
    Name = "Instance test"
  }
}
