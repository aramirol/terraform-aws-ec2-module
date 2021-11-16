# Output instances BASIC

output "instances_ip_basic" {
  description = "Instance IP Basic"
  value       = contains(var.ec2_create, "instance_basic") == true ? aws_instance.instance_basic.*.public_ip : null

  depends_on = [
    aws_instance.instance_basic,
  ]
}

output "instances_type_basic" {
  description = "Instance Type Basic"
  value       = contains(var.ec2_create, "instance_basic") == true ? aws_instance.instance_basic.*.instance_type : null
}

output "instances_id_basic" {
  description = "Instance ID Basic"
  value       = contains(var.ec2_create, "instance_basic") == true ? aws_instance.instance_basic.*.id : null 
}

# Output instances PRO

output "instances_ip_pro" {
  description = "Instance IP Pro"
  value       = contains(var.ec2_create, "instance_pro") == true ? aws_instance.instance_pro.*.public_ip : null
}

output "instances_type_pro" {
  description = "Instance Type Pro"
  value       = contains(var.ec2_create, "instance_pro") == true ? aws_instance.instance_pro.*.instance_type : null
}

output "instances_id_pro" {
  description = "Instance ID Pro"
  value       = contains(var.ec2_create, "instance_pro") == true ? aws_instance.instance_pro.*.id : null
}





#  value       = "${aws_instance.instance_basic.*.public_ip}"

#output "test-1" {
#  value = var.instance_type_basic == "t2.nano" ? aws_instance.instance_basic.*.public_ip : null
#}

#output "test-2" {
#  value = contains(var.ec2_create, "instance_basic") == true ? aws_instance.instance_basic.*.public_ip : null
#}