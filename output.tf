# Output instances BASIC

output "instances_ip_basic" {
  description = "Instance IP"
  value       = "${aws_instance.instance_basic.*.public_ip}"
}

output "instances_type_basic" {
  description = "Instance Type "
  value       = "${aws_instance.instance_basic.*.instance_type}"
}

output "instances_id_basic" {
  description = "Instance ID "
  value       = "${aws_instance.instance_basic.*.id}"
}

# Output instances PRO

output "instances_ip_pro" {
  description = "Instance IP"
  value       = "${aws_instance.instance_pro.*.public_ip}"
}

output "instances_type_pro" {
  description = "Instance Type "
  value       = "${aws_instance.instance_pro.*.instance_type}"
}

output "instances_id_pro" {
  description = "Instance ID "
  value       = "${aws_instance.instance_pro.*.id}"
}

output "instances_all" {
  description = "Show all"
  value       = module.ec2_basic.*
}

output "instances_all" {
  description = "Show all"
  value       = module.ec2_pro.*
}