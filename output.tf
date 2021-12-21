# Output instances BASIC

output "ec2_ip" {
  description = "Instance IP"
   value = "${aws_instance.ec2.*.public_ip}"
}

output "ec2_type" {
  description = "Instance Type"
   value = "${aws_instance.ec2.*.instance_type}"
}

output "ec2_id" {
  description = "Instance ID"
   value = "${aws_instance.ec2.*.id}"
}

output "ec2_name" {
  description = "Instance Name"
   value = "${aws_instance.ec2.*.tags.Name}"
}

output "ec2_ami" {
  description = "Instance AMI"
   value = "${aws_instance.ec2.*.ami}"
}