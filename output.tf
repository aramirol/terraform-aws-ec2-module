output "instances_ip" {
  description = "Instance IP"
  value       = "${aws_instance.instance_test_basic.*.public_ip}"
}

output "instances_type" {
  description = "Instance Type "
  value       = "${aws_instance.instance_test_basic.*.instance_type}"
}

output "instances_id" {
  description = "Instance ID "
  value       = "${aws_instance.instance_test_basic.*.id}"
}