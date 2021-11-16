# Output instances BASIC

output "instances_ip" {
  description = "Instance IP"
  value       = contains(var.ec2_create, "yes") == true ? aws_instance.instance_ec2.*.public_ip : null
}

output "instances_type" {
  description = "Instance Type"
  value       = contains(var.ec2_create, "yes") == true ? aws_instance.instance_ec2.*.instance_type : null
}

output "instances_id" {
  description = "Instance ID"
  value       = contains(var.ec2_create, "yes") == true ? aws_instance.instance_ec2.*.id : null 
}