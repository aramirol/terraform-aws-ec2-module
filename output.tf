output "instances_ip" {
  description = "Instance IP"
  value       = "${aws_instance.instance_test_*.*.public_ip}"
}

#output "instances_type" {
#  description = "Instance Type "
#  value       = "${aws_instance.instance_test.*.instance_type}"
#}

#output "instances_id" {
#  description = "Instance ID "
#  value       = "${aws_instance.instance_test.*.id}"
#}