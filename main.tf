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
#  count                   = contains(var.ec2_create, "yes") == true ? 1 : 0 # Execute this resource if "ec2_create" var is set to yes.
  count                   = 1
  ami                     = var.ec2_ami
  instance_type           = var.ec2_type
#  key_name                = aws_key_pair.ec2-key.key_name
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

# Defining tls key
##################################################
#resource "tls_private_key" "key" {
#  algorithm = "RSA"
#  rsa_bits  = 4096
#  provider = tls.key
#}

# Defining keypair
##################################################
#resource "aws_key_pair" "ec2-key" {
#  key_name   = "${var.ec2_tag_name}-ec2-key"
#  public_key = tls_private_key.key.public_key_openssh
#}


# Defining main sg
##################################################
resource "aws_security_group" "ec2_sg" {
    name = "${var.ec2_tag_name}-sg"
#    vpc_id = var.vpc_id

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