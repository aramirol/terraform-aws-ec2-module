# Output instances BASIC

output "instance_ip" {
  description = "Instance IP"
  value       = contains(var.ec2_create, "yes") == true ? aws_instance.instance_ec2.*.public_ip : null
}

output "instance_type" {
  description = "Instance Type"
  value       = contains(var.ec2_create, "yes") == true ? aws_instance.instance_ec2.*.instance_type : null
}

output "instance_id" {
  description = "Instance ID"
  value       = contains(var.ec2_create, "yes") == true ? aws_instance.instance_ec2.*.id : null 
}

output "instance_name" {
  description = "Instance Name"
  value       = contains(var.ec2_create, "yes") == true ? aws_instance.instance_ec2.*.instance_name : null 
}