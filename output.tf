# Output instances BASIC

output "instances_ip_basic" {
  description = "Instance IP Basic"
  value       = contains(var.ec2_create, "yes") == true ? aws_instance.instance_ec2.*.public_ip : null
}

output "instances_type_basic" {
  description = "Instance Type Basic"
  value       = contains(var.ec2_create, "yes") == true ? aws_instance.instance_ec2.*.instance_type : null
}

output "instances_id_basic" {
  description = "Instance ID Basic"
  value       = contains(var.ec2_create, "yes") == true ? aws_instance.instance_ec2.*.id : null 
}