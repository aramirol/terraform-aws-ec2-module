# Output instances BASIC

output "instances_ip_basic" {
  description = "Instance IP Basic"
#  value       = "${aws_instance.instance_basic.*.public_ip}"
  value       = contains(var.ec2_create, "ec2_basic") != true ? null : aws_instance.instance_basic.*.public_ip
}

output "instances_type_basic" {
  description = "Instance Type Basic"
#  value       = "${aws_instance.instance_basic.*.instance_type}"
  value       = contains(var.ec2_create, "ec2_basic") != true ? null : aws_instance.instance_basic.*.instance_type
}

output "instances_id_basic" {
  description = "Instance ID Basic"
#  value       = "${aws_instance.instance_basic.*.id}"
  value       = contains(var.ec2_create, "ec2_basic") != true ? null : aws_instance.instance_basic.*.id
}

# Output instances PRO

output "instances_ip_pro" {
  description = "Instance IP Pro"
#  value       = "${aws_instance.instance_pro.*.public_ip}"
  value       = contains(var.ec2_create, "ec2_pro") != true ? null : aws_instance.instance_pro.*.public_ip
}

output "instances_type_pro" {
  description = "Instance Type Pro"
#  value       = "${aws_instance.instance_pro.*.instance_type}"
  value       = contains(var.ec2_create, "ec2_pro") != true ? null : aws_instance.instance_pro.*.instance_type
}

output "instances_id_pro" {
  description = "Instance ID Pro"
#  value       = "${aws_instance.instance_pro.*.id}"
  value       = contains(var.ec2_create, "ec2_pro") != true ? null : aws_instance.instance_pro.*.id
}
