# Output instances BASIC

output "instances_ip" {
  description = "Instance IP"
  value       = "${aws_instance.instance_basic.*.public_ip}"
}

output "instances_type" {
  description = "Instance Type "
  value       = "${aws_instance.instance_basic.*.instance_type}"
}

output "instances_id" {
  description = "Instance ID "
  value       = "${aws_instance.instance_basic.*.id}"
}

# Output instances PRO

output "instances_ip" {
  description = "Instance IP"
  value       = "${aws_instance.instance_pro.*.public_ip}"
}

output "instances_type" {
  description = "Instance Type "
  value       = "${aws_instance.instance_pro.*.instance_type}"
}

output "instances_id" {
  description = "Instance ID "
  value       = "${aws_instance.instance_pro.*.id}"
}