# EC2 resource
##################################################

# Get AZ subnet from 1a
##################################################
data "aws_subnet" "az_a" {
    availability_zone = "${var.ec2_region}a"
}

# Create EC2 instance
##################################################
resource "aws_instance" "ec2" {
  count                   = 1
  ami                     = var.ec2_ami
  instance_type           = var.ec2_type
  user_data               = var.user_data
  placement_group         = var.placement_group
  private_ip              = var.private_ip
  subnet_id               = data.aws_subnet.az_a.id
  vpc_security_group_ids  = [aws_security_group.ec2_sg.id]
  disable_api_termination = false

  root_block_device {
    encrypted = true
  }

  tags = {
    Name = "${var.ec2_tag_name}-${count.index}"
    Environment = var.ec2_tag_env
  }
}

# Defining main sg
##################################################
resource "aws_security_group" "ec2_sg" {
    name = "${var.ec2_tag_name}-sg"

    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        description = "Access only via port ${var.ec2_instance_port}"
        from_port = var.ec2_instance_port
        to_port = var.ec2_instance_port
        protocol = "TCP"
    }

    egress {
        cidr_blocks = ["0.0.0.0/0"]
        description = "Acceso al puerto 8080 desde nuestros servidores"
        from_port = 0
        to_port = 0
        protocol = "TCP"
    }
}