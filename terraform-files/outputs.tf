output "ansible_info" {
  value = {
    public_ip  = aws_instance.ansible.public_ip
    private_ip = aws_instance.ansible.private_ip
  }

}
output "master_info" {
  value = {
    public_ip  = aws_instance.jenkins_master.public_ip
    private_ip = aws_instance.jenkins_master.private_ip
  }
}
output "slave_info" {
  value = {
    public_ip  = aws_instance.jenkins_slave.public_ip
    private_ip = aws_instance.jenkins_slave.private_ip
  }
}