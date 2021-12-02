# Output instances BASIC

output "ec2_ip" {
  description = "Instance IP"
#  value       = contains(var.ec2_create, "yes") == true ? aws_instance.ec2.*.public_ip : null
   value = "${aws_instance.ec2.*.public_ip}"
}

output "ec2_type" {
  description = "Instance Type"
#  value       = contains(var.ec2_create, "yes") == true ? aws_instance.ec2.*.instance_type : null
   value = "${aws_instance.ec2.*.instance_type}"
}

output "ec2_id" {
  description = "Instance ID"
#  value       = contains(var.ec2_create, "yes") == true ? aws_instance.ec2.*.id : null 
   value = "${aws_instance.ec2.*.id}"
}

output "ec2_name" {
  description = "Instance Name"
#  value       = contains(var.ec2_create, "yes") == true ? aws_instance.ec2.*.tags.Name : null 
   value = "${aws_instance.ec2.*.tags.Name}"
}