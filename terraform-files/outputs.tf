output "ansible_info" {
  value = aws_instance.ansible.public_ip
}
output "master_info" {
  value = aws_instance.jenkins_master.public_ip
}
output "slave_info" {
  value = aws_instance.jenkins_slave.public_ip
}